Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C1580133F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379289AbjLATAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjLATAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E407910DA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701457209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m41LLKgfTnOgM1rZWGXKDoV2xNtfCXmSDGiVFJ2E2HI=;
        b=EQjJX6ybLzUJQmjlIXpoT7jlq6QiXYpw44v525CmMEHrUpx413tgp+62GcGbaHJ/6nAyQC
        aaqHlPiDIZpa8+CZyigiy5mrjra7co/BXBO10mcYtkKVvoQC+LNLfnvxmbXgx68VkKBI4j
        9Y83LzXlD+3PHqVxkIoM/HC6nfK7ST8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-DHXoauT0NNmV2BQXrJad-g-1; Fri, 01 Dec 2023 14:00:07 -0500
X-MC-Unique: DHXoauT0NNmV2BQXrJad-g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40a3d918dc1so3986655e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 11:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457206; x=1702062006;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m41LLKgfTnOgM1rZWGXKDoV2xNtfCXmSDGiVFJ2E2HI=;
        b=Vb1Ae9uPHbIoSkTv0r1Vrwz5WEmZ33lnPeOxRIqMJ3oBpBpXN7upk9CktskZOsToBm
         4P4XQIrTGWwU7rU6mkY7BfN/xyq5pxMk+MR9YU5HxOhFNYqMIwEjeBMtN8j6cLiiuj8n
         CuUM3WoeL/6/Hwb/Ewss/ts6VSVNOlvKAwr169WBIVib9GdsqTjtmveUo2bs9NuTGyvd
         ny+SCEncIAA2V2EF/ZrSjMhrf0HUpHSAuqsTNgdh/KIjCUYYNXT7XYMuLaSGsHeKGDJO
         uNTxkF9kLG38wCnUxgLVonghISIHZcwd1pTYOCPP1zjCO0LcLUNuBXwt+J/UMmo6jPor
         Lc3Q==
X-Gm-Message-State: AOJu0YzaDMlAHGl0D0KwToCYF82QE+QFGjRl3EqgejzU/RoLyD4Xsc0k
        jwKdO0h5LusCmt00Zm6F4s0RYw256HWZk3bWymeyRZ+RFQfJIwTRKkVPF7cheeax0b/sfO3hlUe
        wH3WhBDlh+vUTrq50vXkB4bz0
X-Received: by 2002:a5d:5889:0:b0:333:362e:8416 with SMTP id n9-20020a5d5889000000b00333362e8416mr330985wrf.0.1701457206635;
        Fri, 01 Dec 2023 11:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb31Qn5jnGDryDULukDS8yw9/j8mm87Arm4MPjyniF6L5X3AMBJABucr2yZHjHSgyTVs+IlA==
X-Received: by 2002:a5d:5889:0:b0:333:362e:8416 with SMTP id n9-20020a5d5889000000b00333362e8416mr330966wrf.0.1701457206306;
        Fri, 01 Dec 2023 11:00:06 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4686000000b0033315876d3esm4877262wrq.12.2023.12.01.11.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:00:05 -0800 (PST)
Message-ID: <90423946a0dbdcdb7cb3c93b3897683ce07c5e69.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] lib: move pci-specific devres code to
 drivers/pci/
From:   Philipp Stanner <pstanner@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        Neil Brown <neilb@suse.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Date:   Fri, 01 Dec 2023 20:00:03 +0100
In-Reply-To: <32552a65-b540-4baa-9180-e04a278f0ca6@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
         <20231201121622.16343-3-pstanner@redhat.com>
         <32552a65-b540-4baa-9180-e04a278f0ca6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 15:44 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> > The pcim_*() functions in lib/devres.c are guarded by an #ifdef
> > CONFIG_PCI and, thus, don't belong to this file. They are only ever
> > used
> > for pci and are not generic infrastructure.
> >=20
> > Move all pcim_*() functions in lib/devres.c to
> > drivers/pci/devres.c.
> > Adjust the Makefile.
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
> I still think this should go into drivers/pci/pci_iomap.c along
> with the other functions.

I understand where you're coming from, but the technical reason I'm
doing it this way is the same topic as in patch =E2=84=961:

@@ -14,6 +14,7 @@ ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+=3D proc.o
 obj-$(CONFIG_SYSFS)		+=3D slot.o
 obj-$(CONFIG_ACPI)		+=3D pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) +=3D iomap.o
 endif


As you pointed out very correctly, I removed the #ifdef PCI in the
iomap.c functions, which would result in build failure, because the
file has to be made empty if GENERIC_PCI_IOMAP is selected and PCI is
not

The devres functions have different compile rules than the iomap
functions have.

I would dislike it very much to need yet another preprocessor
instruction, especially if we're talking about #ifdef PCI within the
very PCI driver.

P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20

