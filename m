Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C37BA493
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbjJEQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbjJEQEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6C4CFA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJEa+gWdlvljcsxPLx3PWHMvt63pRc6Ikwaz2vOfIPg=;
        b=IrckMHJUYzDlE8vJXwjY5OYAh/vE0BqfsFEyncI4npHdbfqiXlzM2TrQIiK5nQZBgZbiqQ
        NiV2Vb2owsD9xrtLzaLMcOYkuulMUm9M36HLGUmVe3I6wIb4ZecbYY9ZeaLtNoG54eBAd2
        E2zIxJqXfY1s6U574y3Z/Hut8yxFLvQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-B-gBkZ-vP_G1tR-P1LGiVA-1; Thu, 05 Oct 2023 06:34:04 -0400
X-MC-Unique: B-gBkZ-vP_G1tR-P1LGiVA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-535445b3e60so91258a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502043; x=1697106843;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJEa+gWdlvljcsxPLx3PWHMvt63pRc6Ikwaz2vOfIPg=;
        b=Wrx7VXfBpy6vY2gYwJr2hUaQtO7OEyDcZIpFgm06XWwajXtUGLpf4O+ug6WsfcYs/H
         YQMmSTrPIPIVv8/7tcDYjU5puodjU2qZKKvDnduq7lG/EVOgtbdPg1BBshEouqm31/tj
         7EfSCXWsTpy8bM4oufi4OP7ciJdhj4V2gm725PSnDo8AiwnlthGfnF7WvFVi4p8c9dne
         c4QFV+WZd++zB11r8VKAhwBfeKi9RZ3nHyHpNfZ7y1nBcGMLDcZYtKccd8zOn5Jw4mTV
         N2VvjQo4SDST9+6NclC6t4TeV46eMmKDhUPy4MvR5yOeo7uG8SxWUq0s7gw6hfIpqItF
         r7Ng==
X-Gm-Message-State: AOJu0YzYcenyKcLuQ+ti2jVitmtOh6uCS4s+qZstMAQE7Ora8jIVO2QH
        vb/Hk+ihTc9QvAF0wQ0qxJ/vjO0bK8oS8bn9Hb3IZNC0kkT7ouhJtpugy4okvXKkqygJeR2vpss
        lj0/TR+WTzBDyF115qdwp/ZzC
X-Received: by 2002:a05:6402:278c:b0:523:2e64:122b with SMTP id b12-20020a056402278c00b005232e64122bmr4222458ede.3.1696502043147;
        Thu, 05 Oct 2023 03:34:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBjwOxGN0mroujhop9lSt9BQu5QPOyNH8DNEdnCagtFe3aIYksxxEYiMpkoc5gI5XLXtgVuw==
X-Received: by 2002:a05:6402:278c:b0:523:2e64:122b with SMTP id b12-20020a056402278c00b005232e64122bmr4222432ede.3.1696502042791;
        Thu, 05 Oct 2023 03:34:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-9.dyn.eolo.it. [146.241.225.9])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b005231e3d89efsm867932edx.31.2023.10.05.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:34:02 -0700 (PDT)
Message-ID: <6845daf40e0bd79c9768e83928b308e84459c010.camel@redhat.com>
Subject: Re: [PATCH v3] net: phy: broadcom: add support for BCM5221 phy
From:   Paolo Abeni <pabeni@redhat.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
Date:   Thu, 05 Oct 2023 12:34:00 +0200
In-Reply-To: <20230928185949.1731477-1-giulio.benetti@benettiengineering.com>
References: <20230928185949.1731477-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 20:59 +0200, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
>=20
> This patch adds the BCM5221 PHY support by reusing brcm_fet_*()
> callbacks and adding quirks for BCM5221 when needed.
>=20
> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.c=
om>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> Suggested by Andrew Lunn:
> * handle mdix_ctrl adding bcm5221_config_aneg() and bcm5221_read_status()
> * reorder PHY_ID_BCM5241 in broadcom_tbl[]
> Suggested by Russell King:
> * add comment on phy_read(..., MII_BRCM_FET_INTREG)
> * lock mdio bus when in shadow mode
> Suggested by Florian Fainelli:
> * reuse brcm_fet_*() callbacks checking for phy_id =3D=3D PHY_ID_BCM5221
>=20
> V2->V3:
> * rebase on master branch

LGTM, but waiting an extra bit for explicit ack from Florian.

Cheers,

Paolo

