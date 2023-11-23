Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735D87F5C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjKWKVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWKVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932FAD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700734901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sgtmdSW98J90Kfrs7HiPvT9RZVZuwuMmB0Gp4wHhzs0=;
        b=FW7LZry9+savVC1KQEIigDUnKjwFpVD/3px2n//2/5iRtkkqPQve1zPM/BUgZzo7T3rMK4
        I+2bGQKqupH3Cw5eHEqAOzlhkB1Wvo8lLPT8C9OcqRroBhD9bzi04CBqfJVOb/duf4eAWR
        PBDUg93YdejCk3uImmcgxDfRdQxihqY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-u-XujyXfO6OZV-W3j95F2Q-1; Thu, 23 Nov 2023 05:21:40 -0500
X-MC-Unique: u-XujyXfO6OZV-W3j95F2Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a0627211f11so9364866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734899; x=1701339699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgtmdSW98J90Kfrs7HiPvT9RZVZuwuMmB0Gp4wHhzs0=;
        b=wqrAk9Opa/KgGYHNwBcGivUha5qZWkHjijIKlIy9pr9Ayb8/4xF3xQJD3h/fjoV1uh
         HSV5kg4getPpmOYvXpZm+c9kcmbsFdmftbjiy8v0ONtGK/l3hDEQxc/GnkNsXlkldKTQ
         lWwPGD0qXOLoRI4q9V8NjlVaTPMGgknGEN2ulG8jqDUfsJrFmoH7NHRk1Emvr6ICDK/l
         c1P/IYpt041Mq5/HkHuRB+qdkyWcj91OhHFKjqbCGYtIBqIfSandw5QMMLn4zSJgxhDD
         2h6tmCA/wQlSjCbKg6hSe/B5gDsjHZFEqijnHxsDq3yyxcLHt+Rg7vMzX/E6XvRWbe5x
         wWiQ==
X-Gm-Message-State: AOJu0YyJ1fDuBvun6rrS+AWRsx08zhrKre9v6268IZAX7aK3AAp0PyMm
        wyR0r32NIodilaTONJHJLvnYmxl6GAHygle22LOad3aFosmh2QRWtXJg52P4VdFrKH3UZGgJimy
        C/fMQbPOlIaIr+JvSYNoFiMjh
X-Received: by 2002:a17:906:10cd:b0:a01:8f8c:ea9 with SMTP id v13-20020a17090610cd00b00a018f8c0ea9mr2938369ejv.7.1700734898916;
        Thu, 23 Nov 2023 02:21:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9/qQ+NdZJcbqQ0VKAwLvuSjGjtIxOO3YUeVJI75tXFZhR3SCYSFE8g8GINDJP9qeeh8oRbA==
X-Received: by 2002:a17:906:10cd:b0:a01:8f8c:ea9 with SMTP id v13-20020a17090610cd00b00a018f8c0ea9mr2938353ejv.7.1700734898554;
        Thu, 23 Nov 2023 02:21:38 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id ay8-20020a170906d28800b009b928eb8dd3sm587756ejb.163.2023.11.23.02.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:21:38 -0800 (PST)
Message-ID: <92d95955f66098ce725729243251beacc2823a81.camel@redhat.com>
Subject: Re: [net-next PATCH v3 2/2] octeontx2-pf: TC flower offload support
 for mirror
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wojciech Drewek <wojciech.drewek@intel.com>,
        Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lcherian@marvell.com, jerinj@marvell.com, horms@kernel.org
Date:   Thu, 23 Nov 2023 11:21:36 +0100
In-Reply-To: <ee30eaa0-2a1f-4dc6-8e03-c2d993eb159a@intel.com>
References: <20231121094346.3621236-1-sumang@marvell.com>
         <20231121094346.3621236-3-sumang@marvell.com>
         <ee30eaa0-2a1f-4dc6-8e03-c2d993eb159a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 15:48 +0100, Wojciech Drewek wrote:
>=20
> On 21.11.2023 10:43, Suman Ghosh wrote:
> > This patch extends TC flower offload support for mirroring
> > ingress/egress traffic to a different PF/VF. Below is an example
> > command,
> >=20
> > 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
> > skip_sw action mirred ingress mirror dev eth2'
> >=20
> > Signed-off-by: Suman Ghosh <sumang@marvell.com>
>=20
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Thank you for your review!

Please, additionally try to trim away the irrelevant part of the patch
when replying (in this case almost everything). That helps a lot
following the discussion, especially on long patches, thanks!

@Suman: please retain Wojciech's tag on next revision of this series.

Cheers,

Paolo

