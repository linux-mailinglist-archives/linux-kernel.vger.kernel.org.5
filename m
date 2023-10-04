Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1097B8339
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbjJDPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjJDPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:11:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F90993
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:11:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 284E9C15;
        Wed,  4 Oct 2023 08:12:05 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F7873F762;
        Wed,  4 Oct 2023 08:11:25 -0700 (PDT)
Date:   Wed, 4 Oct 2023 16:11:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Subject: Re: [PATCH v3 07/17] firmware: arm_ffa: Implement the
 NOTIFICATION_INFO_GET interface
Message-ID: <20231004151123.z4w5u3j7a743bmdq@bogus>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-7-c8e4f15190c8@arm.com>
 <20231004091021.GA1091193@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004091021.GA1091193@rayden>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:10:21AM +0200, Jens Wiklander wrote:
> On Fri, Sep 29, 2023 at 04:02:56PM +0100, Sudeep Holla wrote:
> > The receiver’s scheduler uses the FFA_NOTIFICATION_INFO_GET interface
> > to retrieve the list of endpoints that have pending notifications and
> > must be run. A notification could be signaled by a sender in the secure
> > world to a VM. The Hypervisor needs to determine which VM and vCPU
> > (in case a per-vCPU notification is signaled) has a pending notification
> > in this scenario. It must obtain this information through an invocation
> > of the FFA_NOTIFICATION_INFO_GET.
> > 
> > Add the implementation of the NOTIFICATION_INFO_GET interface
> > and prepare to use this to handle the schedule receiver interrupt.
> > Implementation of handling notifications will be added later.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 70 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 02eedb7bc171..dfeeb751bebe 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -602,6 +602,13 @@ static int ffa_notification_bitmap_destroy(void)
> >  	(FIELD_PREP(RECEIVER_VCPU_MASK, (vcpu_r)) | \
> >  	 FIELD_PREP(RECEIVER_ID_MASK, (r)))
> >  
> > +#define NOTIFICATION_INFO_GET_MORE_PEND_MASK	BIT(0)
> > +#define NOTIFICATION_INFO_GET_ID_COUNT		GENMASK(11, 7)
> > +#define ID_LIST_MASK_64				GENMASK(51, 12)
> > +#define ID_LIST_MASK_32				GENMASK(31, 12)
> > +#define MAX_IDS_64				20
> > +#define MAX_IDS_32				10
> > +
> >  static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
> >  					u32 flags, bool is_bind)
> >  {
> > @@ -673,6 +680,69 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
> >  	return 0;
> >  }
> >  
> > +static void __do_sched_recv_cb(u16 partition_id, u16 vcpu, bool is_per_vcpu)
> > +{
> > +	pr_err("Callback for partition 0x%x failed.\n", partition_id);
> > +}
> > +
> > +static void ffa_notification_info_get(bool is_64b)
> > +{
> > +	int idx, list, max_ids, lists_cnt, ids_processed, ids_count[MAX_IDS_64];
> > +	ffa_value_t ret;
> > +	u64 id_list;
> > +
> > +	do {
> > +		invoke_ffa_fn((ffa_value_t){
> > +			  .a0 = FFA_FN_NATIVE(NOTIFICATION_INFO_GET),
> > +			  }, &ret);
> > +
> > +		if (ret.a0 != FFA_FN_NATIVE(SUCCESS)) {
> 
> The specification doesn't require a response using 64-bit SMCCC, it is
> valid to respond using 32-bit SMCCC too.
>

Do you mean to say the we need to support 64b NOTIFICATION_INFO_GET
returning 32b FFA_SUCCESS ? If so do we need to assume only 32bits are
used in the result. As per the specification,

"0xC4000061(FFA_FN64_SUCCESS): This function ID is used only if any result
 register encodes a 64-bit parameter."

My question is what that means allowing 32bit FFA_SUCCESS here?

-- 
Regards,
Sudeep
