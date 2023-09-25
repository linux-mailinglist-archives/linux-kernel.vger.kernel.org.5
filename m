Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5797AD481
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjIYJ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjIYJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:29:03 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DBCAB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:28:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F6C0C0002;
        Mon, 25 Sep 2023 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695634135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wb/VrieiCtDAYPKDjADMUjE31jHuvIRimSKAaJ2SM/g=;
        b=C3wlVNaKwwXz12xJoi3QjL/QFrFwLsMhFhmv8R0SaR1/hLRwQoYSeZPsRD/enXjygSmFSH
        wuSVdaMANskcgC9DJRbxxQeQax3NLFQGqLgg0C4ynSWtoHixTbt1FY5b1hcaLrgPo+3OJ9
        o6nkTWHVDnAjOx2DmKErnPbLkgor8OTRjx9kNJdh0ns3GCPjmC5IMbKj4xpbWIj1/xD+rJ
        krmiQd1V4eQ768mxfqu819wm86a1vQ0nMhPhsIvHBpBzju1NWsdSCEj8308+iMso4iXOwf
        skgE6QoOTMjH2Ez2a2fr09ZRqhMkn2nAhsLntLxNWN5vJmyQWIbQQpKT3vsmWg==
Date:   Mon, 25 Sep 2023 11:28:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>, yangerkun@huawei.com
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
Message-ID: <20230925112853.6cb7fff3@xps-13>
In-Reply-To: <495954216.80155.1695633280285.JavaMail.zimbra@nod.at>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
        <20230925104938.3f7b4284@xps-13>
        <495954216.80155.1695633280285.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

richard@nod.at wrote on Mon, 25 Sep 2023 11:14:40 +0200 (CEST):

> ----- Urspr=C3=BCngliche Mail -----
> >> 'total_retlen' is 0, not the error code. =20
> >=20
> > Actually after looking at the code, I have no strong opinion
> > regarding whether we should return 0 or an error code in this case.
> >=20
> > There is this comment right above, and I'm not sure it is still up to
> > date because I believe many drivers just don't provide the data upon
> > ECC error:
> >=20
> >                /* Nand returns -EBADMSG on ECC errors, but it returns
> >                 * the data. For our userspace tools it is important
> >                 * to dump areas with ECC errors!
> >                 * For kernel internal usage it also might return -EUCLE=
AN
> >                 * to signal the caller that a bitflip has occurred and =
has
> >                 * been corrected by the ECC algorithm.
> >                 * Userspace software which accesses NAND this way
> >                 * must be aware of the fact that it deals with NAND
> >                 */
> >  =20
> >> This problem causes the user-space program to encounter EOF when it has
> >> not finished reading the mtd partion, and this also violates the read
> >> system call standard in POSIX. =20
>=20
> This is a special purpose device file and not a regular file.
> Please explain in detail why this violates POSIX and which program breaks.
>=20
> As pointed out by Miquel, the comment makes it clean that this behavior is
> on purpose. If we return now all of a sudden -EBADMSG for the described
> scenario we might even break existing MTD userspace.

The bugzilla link in the commit log [1] mentions:

* dd would just stop in the middle without showing errors
  -> we probably don't care, we expect the userspace to know this is
  NAND when dealing with mtd devices directly, dd is not mtd-aware
  anyway.

* ubiformat would loop forever
  -> that one needs attention I guess :)

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217939

Thanks,
Miqu=C3=A8l
