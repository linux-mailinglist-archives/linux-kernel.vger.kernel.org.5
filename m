Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327A280D4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbjLKSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbjLKSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:08:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8679595;
        Mon, 11 Dec 2023 10:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702318119; x=1733854119;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zsHw8c+yNsgNCrRgEh9GvMAaMJXHxP/gdyNdElE3dk0=;
  b=HQlnKKQiDoZ3kwztSPtqoh1ltPlKiqIBzO9SxKKDOFpYKye8GAJqAlD/
   RtjEEhGVylp02QZuArCpPGYvMiMEWl3p5m0AjlmsD9+zwjtKkRb17iuPy
   fUrvHFxmiPkihDEyq0fewHilmfaTq8X06f8TQKXryhB0oLN8U8zEhH3Mc
   oIrAnJNiXWPL7YKvB8dgwmPM66FIF3HeHzC4SFt1oIeXCrSCY7OYRAkGY
   xtFd5mQqUoDVzaODK5jsBeqNSLq7or0eiCh5fgQEmUdEYASFDG2YHG1s0
   GVzCSkssnwhs+j5OW8QNsZB/WXTuz3OlkWkJ3T4i3kXqV1Xxd2kA9WL4v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="425810997"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="425810997"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="17595834"
Received: from ashnaupa-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.96.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:08:37 -0800
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Rodrigo CADORE CATALDO <rodrigo.cadore@l-acoustics.com>,
        Rodrigo Cataldo via B4 Relay 
        <devnull+rodrigo.cadore.l-acoustics.com@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
        Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>
Cc:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: RE: [PATCH iwl-net] igc: Fix hicredit calculation
In-Reply-To: <PR0P264MB1930850228C3F58EE8B7F9FAC88FA@PR0P264MB1930.FRAP264.PROD.OUTLOOK.COM>
References: <20231208-igc-fix-hicredit-calc-v1-1-7e505fbe249d@l-acoustics.com>
 <871qbwry9y.fsf@intel.com>
 <PR0P264MB1930850228C3F58EE8B7F9FAC88FA@PR0P264MB1930.FRAP264.PROD.OUTLOOK.COM>
Date:   Mon, 11 Dec 2023 10:08:37 -0800
Message-ID: <87v894r4re.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo CADORE CATALDO <rodrigo.cadore@l-acoustics.com> writes:

>> -----Original Message-----
>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> 
>> Rodrigo Cataldo via B4 Relay
>> <devnull+rodrigo.cadore.l-acoustics.com@kernel.org> writes:
>> 
>> > From: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>> >
>> > According to the Intel Software Manual for I225, Section 7.5.2.7,
>> > hicredit should be multiplied by the constant link-rate value, 0x7736.
>> >
>> > Currently, the old constant link-rate value, 0x7735, from the boards
>> > supported on igb are being used, most likely due to a copy'n'paste, as
>> > the rest of the logic is the same for both drivers.
>> >
>> > Update hicredit accordingly.
>> >
>> > Fixes: 1ab011b0bf07 ("igc: Add support for CBS offloading")
>> > Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>> > Signed-off-by: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>> > ---
>> 
>> Very good catch.
>> 
>> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> 
>> Just for curiosity, my test machines are busy right now, what kind of
>> difference are you seeing?
>> 
>
> Hello Vinicius, thank you for the ACK.
>
> For our internal setup, this does not make a difference. My understanding is 
> that hicredit is used for non-SR traffic mixed with SR traffic (i.e., hicredit is
> directly related to the max non-SR frame size). But our setup does not mix
> them (q0 is used only for milan audio/clock SR class A).

I see.

>
> Let me know if you think we need a testcase for this.
>

It was just curiority. No need. Thanks.

>> > This is a simple fix for the credit calculation on igc devices
>> > (i225/i226) to match the Intel software manual.
>> >
>> > This is my first contribution to the Linux Kernel. Apologies for any
>> > mistakes and let me know if I improve anything.
>> > ---
>> >  drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> > index a9c08321aca9..22cefb1eeedf 100644
>> > --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> > +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> > @@ -227,7 +227,7 @@ static int igc_tsn_enable_offload(struct igc_adapter
>> *adapter)
>> >                       wr32(IGC_TQAVCC(i), tqavcc);
>> >
>> >                       wr32(IGC_TQAVHC(i),
>> > -                          0x80000000 + ring->hicredit * 0x7735);
>> > +                          0x80000000 + ring->hicredit * 0x7736);
>> >               } else {
>> >                       /* Disable any CBS for the queue */
>> >                       txqctl &= ~(IGC_TXQCTL_QAV_SEL_MASK);
>> >
>> > ---
>> > base-commit: 2078a341f5f609d55667c2dc6337f90d8f322b8f
>> > change-id: 20231206-igc-fix-hicredit-calc-028bf73c50a8
>> >
>> > Best regards,
>> > --
>> > Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
>> >
>> 
>> Cheers,
>> --
>> Vinicius
>
> Best Regards,
> Rodrigo Cataldo


Cheers,
-- 
Vinicius
