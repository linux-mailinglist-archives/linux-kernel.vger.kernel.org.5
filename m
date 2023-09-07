Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1444797424
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbjIGPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbjIGPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3DC1700
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694100627;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTcoIP+BxxdE5HCzwkgXZ5pvDvriKUgCpDo0vVsd7mk=;
        b=ZmVjsCuk151Bigi/YcGBxaP3p2BXb03Wz+C9xIY2gQJ+xPv3RqCi/sP5FSQuscR6u8jxH2
        ZCtAAl2Rc1HaRON+y8pk6G/owFhZV8JetnCDkH+SqZAVjqzZLKABcrX7wxXgzsaSv6f5n2
        yPd4srBCc8qD0yKGW2DmvEFjM0rr/Xk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-Gq_zTHGfOFyl9M6bBf2L1Q-1; Thu, 07 Sep 2023 03:01:16 -0400
X-MC-Unique: Gq_zTHGfOFyl9M6bBf2L1Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a621359127so36084966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 00:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694070075; x=1694674875;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTcoIP+BxxdE5HCzwkgXZ5pvDvriKUgCpDo0vVsd7mk=;
        b=SKqAmVR4lxecDStdoPMvXcPUutU1sbuEXcB6zQs29o81jEQCoqG76O54lvBd5xcGc3
         GDSDRkB8GpR1AbNJnz8PjGcUcVUC0wmP1Pi5dI7BiM4Oghj6IBsYiESAyo7WPjop2BrN
         4H5yB8Yucq5HdQYeGaMRIMJUwc9oWOoi3fOafip0x9fcjwyWxQO82p63htbvSTP0eBun
         Bvc0iMRN+yfxGnMV3gLF9V7p8whySbqVg4HhyURk2XcGaCLeYjQpM7tZIyTSFCmJcY8v
         6rsnxRAl9iamK+ydtFsfYqVJi7pXK8xkrkp+cZabLnambRa3EkfbKGLlGuIUz2szVNtf
         KIjg==
X-Gm-Message-State: AOJu0YyE/rrDOqVGPtYFPDUCwTlXsgli1UJq/y9oS6hNLjSpEJOrvslV
        BxC4xZHhthRx1LATMPdO1ze7RfEtR0tEIpjwoUmztmSCQWLWovVd/AstTJmthEKhX/8daWAmub5
        zXR9x/iXy0zRsxqJwHYZnQOn4
X-Received: by 2002:a17:907:2bd1:b0:9a2:120a:5779 with SMTP id gv17-20020a1709072bd100b009a2120a5779mr3861423ejc.60.1694070075040;
        Thu, 07 Sep 2023 00:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC/WLksUsozPJJzUtAHQVN8tmHoVEXTKyeYuwNnag5MRAgx6Av6BIm0cEM4J/UKhVcOE0/uw==
X-Received: by 2002:a17:907:2bd1:b0:9a2:120a:5779 with SMTP id gv17-20020a1709072bd100b009a2120a5779mr3861382ejc.60.1694070074354;
        Thu, 07 Sep 2023 00:01:14 -0700 (PDT)
Received: from [192.168.2.56] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b00988e953a586sm9992680ejb.61.2023.09.07.00.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 00:01:13 -0700 (PDT)
Message-ID: <e461ea2d6134c0f3cfd765d53d6a2228c1bb3677.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] iavf: add
 iavf_schedule_aq_request() helper
From:   Petr Oros <poros@redhat.com>
Reply-To: poros@redhat.com
To:     Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc:     ivecera@redhat.com, intel-wired-lan@lists.osuosl.org,
        jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
        edumazet@google.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net
Date:   Thu, 07 Sep 2023 09:01:10 +0200
In-Reply-To: <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
References: <20230906141411.121142-1-poros@redhat.com>
         <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed Zaki p=C3=AD=C5=A1e v St 06. 09. 2023 v 09:32 -0600:
>=20
> On 2023-09-06 08:14, Petr Oros wrote:
> > Add helper for set iavf aq request AVF_FLAG_AQ_* and imediately
> > schedule watchdog_task. Helper will be used in cases where it is
> > necessary to run aq requests asap
> >=20
> > Signed-off-by: Petr Oros <poros@redhat.com>
> > Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > ---
> > =C2=A0 drivers/net/ethernet/intel/iavf/iavf.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |=C2=A0 2 +-
> > =C2=A0 drivers/net/ethernet/intel/iavf/iavf_main.c=C2=A0=C2=A0=C2=A0 | =
10 ++++------
> > =C2=A0 3 files changed, 6 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> > b/drivers/net/ethernet/intel/iavf/iavf.h
> > index 85fba85fbb232b..e110ba3461857b 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf.h
> > +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> > @@ -521,7 +521,7 @@ void iavf_down(struct iavf_adapter *adapter);
> > =C2=A0 int iavf_process_config(struct iavf_adapter *adapter);
> > =C2=A0 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
> > =C2=A0 void iavf_schedule_reset(struct iavf_adapter *adapter, u64
> > flags);
> > -void iavf_schedule_request_stats(struct iavf_adapter *adapter);
> > +void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64
> > flags);
> > =C2=A0 void iavf_schedule_finish_config(struct iavf_adapter *adapter);
> > =C2=A0 void iavf_reset(struct iavf_adapter *adapter);
> > =C2=A0 void iavf_set_ethtool_ops(struct net_device *netdev);
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > index a34303ad057d00..90397293525f71 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > @@ -362,7 +362,7 @@ static void iavf_get_ethtool_stats(struct
> > net_device *netdev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i;
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Explicitly request s=
tats refresh */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iavf_schedule_request_stats(=
adapter);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iavf_schedule_aq_request(ada=
pter,
> > IAVF_FLAG_AQ_REQUEST_STATS);
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iavf_add_ethtool_stats(=
&data, adapter,
> > iavf_gstrings_stats);
> > =C2=A0=20
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index 7b300c86ceda73..86d472dfdbc10c 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -314,15 +314,13 @@ void iavf_schedule_reset(struct iavf_adapter
> > *adapter, u64 flags)
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /**
> > - * iavf_schedule_request_stats - Set the flags and schedule
> > statistics request
> > + * iavf_schedule_aq_request - Set the flags and schedule aq
> > request
> > =C2=A0=C2=A0 * @adapter: board private structure
> > - *
> > - * Sets IAVF_FLAG_AQ_REQUEST_STATS flag so iavf_watchdog_task()
> > will explicitly
> > - * request and refresh ethtool stats
> > + * @flags: requested aq flags
> > =C2=A0=C2=A0 **/
> > -void iavf_schedule_request_stats(struct iavf_adapter *adapter)
> > +void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64
> > flags)
> > =C2=A0 {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adapter->aq_required |=3D IA=
VF_FLAG_AQ_REQUEST_STATS;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adapter->aq_required |=3D fl=
ags;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mod_delayed_work(adapte=
r->wq, &adapter->watchdog_task, 0);
> > =C2=A0 }
> > =C2=A0=20
>=20
> There are other places where the helper can be used without
> functional=20
> changes, e.g. iavf_add_fdir_ethtool() , iavf_replace_primary_mac()
> and=20
> couple of other places. In all of them, mod_delayed_work() is called=20
> after setting the AQ flag. For the sake of consistency, can you use
> the=20
> helper there too?

These two commits is fixes for issue -> net. But on
iavf_add_fdir_ethtool and iavf_replace_primary_mac is mod_delayed_work
called after spin_unlock_bh ->
looks like no functional chages but i would like be sure and better
will send this to net-next. Are you ok with this?

>=20
>=20
> Thanks,
>=20
> Ahmed
>=20
>=20

