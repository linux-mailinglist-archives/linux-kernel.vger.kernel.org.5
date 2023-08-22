Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FFA783E78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjHVK7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjHVK7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F07CE5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692701889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QwF53F9zwST/a/bBNMeCL1+CzbCBl/0QSzpdsdnjcM=;
        b=ICrvpjmtbus9SjBwkBhWj9i7T8SM6QtMPUvqgsYqaJ0d1Nf1BNjlbmpFeErP4JeCSoT38+
        3wiDUlXDF7ozoQeUSCPzvbAD/Lqjts0TbB28FDC7uUQKJlOfkEhDCX7XjB9lOXx6fdWtaJ
        jV0I9UfT93jBSrGEyOeNIHJfnHG9KkU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-JoQ19cEGPNqyHYtjZJXPlA-1; Tue, 22 Aug 2023 06:58:08 -0400
X-MC-Unique: JoQ19cEGPNqyHYtjZJXPlA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31c5ce917eeso183145f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701887; x=1693306687;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QwF53F9zwST/a/bBNMeCL1+CzbCBl/0QSzpdsdnjcM=;
        b=SrOPFV0jRw6J/PKk7r/lX0VwETmqmT9dSvhxXZ9AaqzEvnBIpxG9B43yhCjfJ66srb
         lpLAyVeGtnmae+gdQypsJ/4bjLoJHqaxnwGaZqdnOvHoGvc053kg9fza8E6cH2Doknm+
         1UMK/kwsqf87qE2Ii3tg+0ssODfKkfJwO024FEIHTp2D8xmAPRdeZKcw9AhifqC8fxyX
         GkWT1jPC0ejNw94SE2sqaS5WS0GCCcPcD8kl92DQZUcW7pyVykjLfxzAtJVLSE5CCq3v
         xlBdGMQtfpvrDqTaidGNqKsOifyOn/OjB3uwUkMYKZF2V2MEp29flEnvSizREUabdr1y
         UJsQ==
X-Gm-Message-State: AOJu0YyeXjLWjkfL/CcfFCKPxDn67vIP9TPRUz2x8mqIdgy06pctCyje
        7M8c5yZKSnafOvfH8aIyhGqKdtU4FjRlgVRUzFanJhrF+Mw0x+U3sJv+V6pP1isMQqJrXwQdCd/
        RjkI1y+Q/i0bfSK0Okgt8T3C8
X-Received: by 2002:a5d:5242:0:b0:31a:d2f9:736b with SMTP id k2-20020a5d5242000000b0031ad2f9736bmr6776129wrc.1.1692701887016;
        Tue, 22 Aug 2023 03:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/gfvQP+q86KUqFZ7cXqs4O29Y4pdllPQAUHuNmDQpG9Jrfa9VxnrVCNIRTHBEC4+4zm6fbw==
X-Received: by 2002:a5d:5242:0:b0:31a:d2f9:736b with SMTP id k2-20020a5d5242000000b0031ad2f9736bmr6776114wrc.1.1692701886650;
        Tue, 22 Aug 2023 03:58:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4d07000000b00317afc7949csm15422903wrt.50.2023.08.22.03.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:58:06 -0700 (PDT)
Message-ID: <d3073c7b5d54e1ad4790b16c419e862fee952350.camel@redhat.com>
Subject: Re: [net PATCH V3 1/3] octeontx2-pf: Fix PFC TX scheduler free
From:   Paolo Abeni <pabeni@redhat.com>
To:     Simon Horman <horms@kernel.org>, Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Aug 2023 12:58:04 +0200
In-Reply-To: <20230822071101.GI2711035@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
         <20230821052516.398572-2-sumang@marvell.com>
         <20230822071101.GI2711035@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Tue, 2023-08-22 at 09:11 +0200, Simon Horman wrote:
> On Mon, Aug 21, 2023 at 10:55:14AM +0530, Suman Ghosh wrote:
> > During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
> > which caused free up all schedulers other than the PFC schedulers.
> > This patch fixes that to free only the PFC Tx schedulers.
> >=20
> > Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> > ---
> >  .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
> >  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b=
/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index 77c8f650f7ac..289371b8ce4f 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > @@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u1=
6 lvl, u16 schq)
> > =20
> >  	mutex_unlock(&pfvf->mbox.lock);
> >  }
> > +EXPORT_SYMBOL(otx2_txschq_free_one);
>=20
> Hi Suman,
>=20
> Given that the licence of both this file and otx2_dcbnl.c is GPLv2,
> I wonder if EXPORT_SYMBOL_GPL would be more appropriate here.

AFAICS all the symbols exported by otx2_common use plain
EXPORT_SYMBOL(). I think we can keep that for consistency in a -net
patch. In the long run it would be nice to move all of them to
EXPORT_SYMBOL_GPL :)

Cheers,

Paolo

