Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC8804473
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjLECGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjLECGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:06:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD68107;
        Mon,  4 Dec 2023 18:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701741993;
        bh=PVO+9wWo6qr4JNuSbUNdvryTDg0uALwlRcXUD0FYi5U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Qe7PBpLN30VLmmGHSk24LtK1Wlb+pWnz7GaTC+B5PVcEpVv+FcO/OKO6IYRYlxXMW
         S1w5i4fJXN3dMAGSqC0mA6U6iSwHYsppoLj8IIdapnWg+1CxN/r4mY+XEofQD3xLeN
         0o/wzmTQPK50vAHNxFU7ejXBLUhKKBtRmxNKaAqWMRL0ZPVW616jGyqBCGBQvH+8S3
         rEFsAlg9tO5aDXNqo1BLhQDB871+paTPvtiqNJw72mVrJDHDFRfU94X5GAlizlBzp2
         4p1OS/JWnB+mgiEEV48ADMAEL/STPwN3jNphO46qchvmvYLN6I1GoFWtlpa1P+lN0D
         r6GGsJbLqOtHQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkkRX3Fwbz4wd0;
        Tue,  5 Dec 2023 13:06:32 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/6] x86: Use PCI_HEADER_TYPE_* instead of literals
In-Reply-To: <20231201225609.GA534714@bhelgaas>
References: <20231201225609.GA534714@bhelgaas>
Date:   Tue, 05 Dec 2023 13:06:29 +1100
Message-ID: <874jgxflne.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> [+cc scsi, powerpc folks]
>
> On Fri, Dec 01, 2023 at 02:44:47PM -0600, Bjorn Helgaas wrote:
>> On Fri, Nov 24, 2023 at 11:09:13AM +0200, Ilpo J=C3=A4rvinen wrote:
>> > Replace 0x7f and 0x80 literals with PCI_HEADER_TYPE_* defines.
>> >=20
>> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>=20
>> Applied entire series on the PCI "enumeration" branch for v6.8,
>> thanks!
>>=20
>> If anybody wants to take pieces separately, let me know and I'll drop
>> from PCI.
>
> OK, b4 picked up the entire series but I was only cc'd on this first
> patch, so I missed the responses about EDAC, xtensa, bcma already
> being applied elsewhere.
>
> So I kept these in the PCI tree:
>
>   420ac76610d7 ("scsi: lpfc: Use PCI_HEADER_TYPE_MFD instead of literal")
>   3773343dd890 ("powerpc/fsl-pci: Use PCI_HEADER_TYPE_MASK instead of lit=
eral")
>   197e0da1f1a3 ("x86/pci: Use PCI_HEADER_TYPE_* instead of literals")
>
> and dropped the others.
>
> x86, SCSI, powerpc folks, if you want to take these instead, let me
> know and I'll drop them.

Nah that's fine, you keep them.

cheers
