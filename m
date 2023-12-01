Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F54801333
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379268AbjLAS4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A410DB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701457003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knBMShKmFlUoH2r+m1jr6Ik+IHyXp9YX9Nzcxs2hiqc=;
        b=ddI24IQJeZXmLka7MOcyU5PFjzIEfapnFllumudlnlbukzH5QJvQrRKJW8mU0TGuOvm6i5
        rPibpdQNhhaqgYgAs1mnxwH5JHHpd8638amOFjPnyxv/GpZ8PmxLmnoAYKzwhAdUNHVe33
        SimmXQl4TNhWee4M4LidaYUf1OtBNUY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-TUAtOt7VNhWPpZlIFdgsvQ-1; Fri, 01 Dec 2023 13:56:41 -0500
X-MC-Unique: TUAtOt7VNhWPpZlIFdgsvQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3333260b3c6so135117f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457000; x=1702061800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knBMShKmFlUoH2r+m1jr6Ik+IHyXp9YX9Nzcxs2hiqc=;
        b=ETvQgnt5FZKSHEUtJpOLoVs8bTynS4yUzvsgRBNVDsqEZg84unj0I69E646l+ZtJ+J
         93DqJ8EkHOKFKDS65EtO8hme8AVNtnTTdPLosBOtrxWpJU30+rMgf9ydJnS/aBvib8xF
         PFAlV7+FtbvoUJbos/ixqbL4TfPgE6tROiR7kDg2i9BAL3qlwKYtVv57UTaS9PLdzmNo
         F16PInHpqyW4DEXC7Dq00ihYxlc6I7hlSoMGcEl8Vxb1BB72cEfNmY1ITVPT7UDIhhAC
         xjkA+q5JW5KQVgKqk46ABIKQVJyyXTKda+U/nFZvMeZwiUzo2tTfBSp9n4fhizNmSaxw
         +IBw==
X-Gm-Message-State: AOJu0YzmTVGWU63ZcLf4y4Mz6F3Z2e0+wtp9ZQ8RC9eSmUHAgEXRS331
        NBhDS2Y3VxinHwbA0hgEB852XwdQ8f9OFMK5/ERm1K9h4zfgcsQt0EmBJXoZ9jPa9yXyL/5oIRd
        vV8WNtt2oM6GuiD67aEF1YHEw
X-Received: by 2002:a5d:6c6c:0:b0:333:30ff:1f69 with SMTP id r12-20020a5d6c6c000000b0033330ff1f69mr2267079wrz.2.1701456999975;
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYgHWBQ7ogcvjbLFWn2No+e3cu9LEahop+KqhFPcJLWwUOIMB6Bc+JurOdJinf9T84hx/+XQ==
X-Received: by 2002:a5d:6c6c:0:b0:333:30ff:1f69 with SMTP id r12-20020a5d6c6c000000b0033330ff1f69mr2267048wrz.2.1701456999652;
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003296b488961sm4857046wru.31.2023.12.01.10.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:56:39 -0800 (PST)
Message-ID: <4bf46893a583551c71bdfbf91df9ccc4b51556b1.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] lib: move pci_iomap.c to drivers/pci/
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
Date:   Fri, 01 Dec 2023 19:56:36 +0100
In-Reply-To: <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
         <20231201121622.16343-2-pstanner@redhat.com>
         <a2b006be-ab4c-4040-b3db-db68d9c77cda@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 15:43 +0100, Arnd Bergmann wrote:
> On Fri, Dec 1, 2023, at 13:16, Philipp Stanner wrote:
> >=20
> > -#ifdef CONFIG_PCI
> > =C2=A0/**
>=20
> You should not remove the #ifdef here, it probably results in
> a build failure when CONFIG_GENERIC_PCI_IOMAP is set and
> GENERIC_PCI is not.

CONFIG_PCI you mean.
Yes, that results in a build failure. That's what the Intel bots have
reminded me of subtly before, which is why I:

>=20
> Alternatively you could use Kconfig or Makefile logic to
> prevent the file from being built without CONFIG_PCI.

did exactly that in this very patch:

@@ -14,6 +14,7 @@ ifdef CONFIG_PCI             <------------
 obj-$(CONFIG_PROC_FS)		+=3D proc.o
 obj-$(CONFIG_SYSFS)		+=3D slot.o
 obj-$(CONFIG_ACPI)		+=3D pci-acpi.o
+obj-$(CONFIG_GENERIC_PCI_IOMAP) +=3D iomap.o     <-----------
 endif


P.

>=20
> =C2=A0=C2=A0 Arnd
>=20

