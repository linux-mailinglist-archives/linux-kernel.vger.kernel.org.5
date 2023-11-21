Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182E17F26E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjKUIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4DBE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700553668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T40r14k+GJH8froFyeHTEYys3h09bU1RbAgHUM0HR7M=;
        b=gxuvrpU4xtzuPWxD8NU/MarKSVkTQafWilbh0DOPdctVud2yCtkVg52/x8i42M3II2gHHj
        VpI6NYR4a1KQRBGgx10c97vGfmjLjhtjhQfv5RM64xOXhl6tijJC9+SyPHKllzw6agznx4
        XTfnSkOcMmdaqJTALUbCTwT2S9UPABM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-RThD87WoPOSrz0bjFwON3g-1; Tue, 21 Nov 2023 03:01:02 -0500
X-MC-Unique: RThD87WoPOSrz0bjFwON3g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-778b5c628f4so71627485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700553662; x=1701158462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T40r14k+GJH8froFyeHTEYys3h09bU1RbAgHUM0HR7M=;
        b=maQhakdCge+Yx87lYAkfQljfXZdfLUPSNPBi8Niq0IxahlElUkA1G5m+iJK5ygX/14
         ri5UHLi+giGQR4m4yh69PD1OA+kqANWANyStw0ZN7k+9vHUJFi0qqWyzKELIIwgwKHEs
         1XWGogUXPmdTobAjFKvJr0MWoW3xSfCAefBwcx9j0R6xeomI12Affr81034SCJQDo7l3
         SxarS8mWiWfvq3j4gdBgQLHEvOVZX64RfLVg8/rqGAGJvjc2SqErQoGyTvFO8Xe/0qfW
         SE8fXiHfrnUtA2mNtur5y+a06oCS72CT9iOf1y/HN3lbBqzSnsHXvnbhZ1Y5LE+ZGW2N
         u0pA==
X-Gm-Message-State: AOJu0YyQ4+Cr9Smx4ruD5MIX8nf3nbCUUuzBhHc+Iaz0otmBvklotCMC
        eT45w6XLskIbWtU28Ahu9PGykdqGYow01yxX0KGu6UbB9+HH2BFwB/P4OHtlZkVu2wJ9aPKcBCt
        daw6arKDUwVPdIYNp4TTnSevK
X-Received: by 2002:a05:620a:1993:b0:776:f188:eee6 with SMTP id bm19-20020a05620a199300b00776f188eee6mr12064289qkb.2.1700553662434;
        Tue, 21 Nov 2023 00:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/fxOrCTKTFdfBU3FfgYL3cQyMCOz/S4+5mT3QDjRE+h9BN8/orrFqxzG87zzge1Rl/wF8Pg==
X-Received: by 2002:a05:620a:1993:b0:776:f188:eee6 with SMTP id bm19-20020a05620a199300b00776f188eee6mr12064272qkb.2.1700553662102;
        Tue, 21 Nov 2023 00:01:02 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id p25-20020a05620a113900b00767dcf6f4adsm3394581qkk.51.2023.11.21.00.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 00:01:01 -0800 (PST)
Message-ID: <d38d1149fdf5eb0cc4da12402ca03604beba1881.camel@redhat.com>
Subject: Re: [PATCH 2/4] lib: move pci-specific devres code to drivers/pci/
From:   Philipp Stanner <pstanner@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Neil Brown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        pstanner@redhat.com
Date:   Tue, 21 Nov 2023 09:00:58 +0100
In-Reply-To: <45997863-d817-48c7-ad46-8b47f5e0ce61@app.fastmail.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
         <20231120215945.52027-4-pstanner@redhat.com>
         <45997863-d817-48c7-ad46-8b47f5e0ce61@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 08:29 +0100, Arnd Bergmann wrote:
> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> > The pcim_*() functions in lib/devres.c are guarded by an #ifdef
> > CONFIG_PCI and, thus, don't belong to this file. They are only ever
> > used
> > for pci and not generic infrastructure.
> >=20
> > Move all pcim_*() functions in lib/devres.c to drivers/pci/devres.c
> >=20
> > Suggested-by: Danilo Krummrich <dakr@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/Makefile |=C2=A0=C2=A0 2 +-
> > =C2=A0drivers/pci/devres.c | 207
> > ++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0lib/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20=
8 +--------------------------------------
> > ----
>=20
> Since you are moving the pci_iomap() code into drivers/pci/ already,
> I'd suggest merging this one into the same file and keep the two
> halves of this interface together.


I'd argue that they are as much together as they were before:

Previously:
 * PCI-IOMAP-code in folder lib/ in its own file (pci_iomap.c)
 * PCI-Devres-code in folder lib/ in a distinct file (devres.c)

Now:
 * PCI-IOMAP-code in folder drivers/pci/ in its own file (iomap.c)
 * PCI-Devres-code in folder drivers/pci/ in its own file (devres.c)

Or am I misunderstanding something?


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20

