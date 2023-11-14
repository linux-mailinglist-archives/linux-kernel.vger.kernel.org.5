Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101257EB699
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjKNSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKNSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:53:13 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFEFF4;
        Tue, 14 Nov 2023 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699987988; bh=oWTjGNgiiSfK20lJ/TB1B4T8+FLsUM8QG3pKaCOeMtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrOH30ayUwdjFc2odNnAUbQ25kDfXHmaKQHxERmh8mP7iAOpa9L35b9nd515v0jya
         Km0OAlRJmmqNatCpT5vzU0Hx6Mat4Kkbzz8J5QV3AKJLZEy+kUDQA+fgGyvut3AvDW
         TyDuis3eyr7vPKraE963bOR1vgQph/atJptzmwJU=
Date:   Tue, 14 Nov 2023 19:53:08 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v1 1/2] scsi: ufs: core: Add UFS RTC support
Message-ID: <18f826db-3146-46ca-9214-eb400588131e@t-8ch.de>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
 <20231109125217.185462-2-beanhuo@iokpp.de>
 <e2e77da5-c344-4913-a321-4cfdcc4a3915@t-8ch.de>
 <e408ce14d322223c1412efa46e8e4d30f44fa98c.camel@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e408ce14d322223c1412efa46e8e4d30f44fa98c.camel@iokpp.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-14 19:27:37+0100, Bean Huo wrote:
> Thank you for your review. I will resolve the highlighted issue in the
> upcoming version. Two separate questions that require individual
> answers as below: 

Thanks for taking the feedback into account!

> On Thu, 2023-11-09 at 15:05 +0100, Thomas Weißschuh wrote:
> > >   static int ufs_get_device_desc(struct ufs_hba *hba)
> > >   {
> > >         int err;
> > > @@ -8237,6 +8321,8 @@ static int ufs_get_device_desc(struct ufs_hba
> > > *hba)
> > >   
> > >         ufshcd_temp_notif_probe(hba, desc_buf);
> > >   
> > > +       ufs_init_rtc(hba, desc_buf);
> > > +
> > 
> > As somebody with no idea and no access to the specs:
> > 
> > Is this available for all devices and all protocol versions?
> > 
> > > 
> I would like to mention that while I cannot confirm that RTC works on
> all protocol versions, it has been consistently functional on all
> devices in the market since the introduction of UFS 2.0, which also
> introduced RTC. I am not aware of any UFS version lower than 2.0
> currently available on the market. In the event that a vendor has a
> product with a lower UFS version, we can consider implementing a
> version check.

Thanks for the info!
Could you mention this somewhere in the commit message?

> > >         goto out;
> > >   
> > >   set_link_active:
> > > @@ -9840,6 +9930,8 @@ static int __ufshcd_wl_resume(struct ufs_hba
> > > *hba, enum ufs_pm_op pm_op)
> > >                 if (ret)
> > >                         goto set_old_link_state;
> > >                 ufshcd_set_timestamp_attr(hba);
> > > +               schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> > > +                                                       msecs_to_ji
> > > ffies(UFS_RTC_UPDATE_EVERY_MS));
> > >         }
> > >   
> > >         if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> > > diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> > > index e77ab1786856..18b39c6b3a97 100644
> > > --- a/include/ufs/ufs.h
> > > +++ b/include/ufs/ufs.h
> > > @@ -14,6 +14,7 @@
> > >   #include <linux/bitops.h>
> > >   #include <linux/types.h>
> > >   #include <uapi/scsi/scsi_bsg_ufs.h>
> > > +#include <linux/rtc.h>
> > 
> > Seems unnecessary.
> 
> seems it's needed, otherwise, I will get:
> ./include/ufs/ufs.h:599:9: error: unknown type name ‘time64_t’

Then it should be "#include <linux/time64.h>", which is more specific.


Thomas
