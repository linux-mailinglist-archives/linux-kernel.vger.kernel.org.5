Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BD07B52CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbjJBMRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbjJBMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:17:01 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E32C10F7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:10:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68D2040004;
        Mon,  2 Oct 2023 12:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696248598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZcXTtPPvML3fSf89NuM1MCWrnP5g92WtwIxjz9b/TuY=;
        b=o+Cn/qC4Ug3B/c0V4o+OalkD6q3vrtx+YSQnHOd6wdA8NhgCc8kwUQMrL/VOo5otaoI9r/
        uoVOS/Ao6bbd7fp9S4eCAGEcAOMd7tRiG0Dz3ZtpG0cGXX1Wf1r3lGw7d1jIxOG5dReqPw
        Csx18ZE78LYanQPDt5vYOROQCUwpxjJyMuMfRYNOLrYHO9tcP+WQeEpZXYRL5D4a2TMAD+
        V5TrK3NERU38ULtydlvfwT2QLfQkamd3Fq55zraukGum1t3MZKbRBgPGAKN0zpcPfmF58L
        +hcqowJIOpXucdRJKhGSFRBpizZ28JKWmQd4YXFxcBmqHLaUnDd5z3IqWg/e5A==
Date:   Mon, 2 Oct 2023 14:09:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] mtd: spinand: add support for FORESEE F35SQA002G
Message-ID: <20231002140953.170c0055@xps-13>
In-Reply-To: <54227489-519b-3268-885f-cf7a9687822b@salutedevices.com>
References: <20230929144934.192649-1-mmkurbanov@salutedevices.com>
        <20231002114450.4ce69141@xps-13>
        <54227489-519b-3268-885f-cf7a9687822b@salutedevices.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

mmkurbanov@salutedevices.com wrote on Mon, 2 Oct 2023 13:18:18 +0300:

> Hi Miquel,
> Thanks for your review.
>=20
> On 02.10.2023 12:44, Miquel Raynal wrote:
> > Hi Martin, =20
> >> +static int f35sqa002g_ooblayout_free(struct mtd_info *mtd, int sectio=
n,
> >> +				     struct mtd_oob_region *region)
> >> +{
> >> +	/* XXX: It is not possible to partially write to this OOB area, as b=
oth
> >> +	 * the main and OOB areas are protected by ECC. The user needs to
> >> +	 * program both the main area and OOB area at one programming time,
> >> +	 * so that the ECC parity code can be calculated properly.
> >> +	 */ =20
> >=20
> > Is this comment really needed? I believe it could be dropped, unless
> > you are really experiencing strange subpage write attempts? =20
>=20
> If you write separately to the main area and the OOB area. This is the
> case with many SPI NAND chips, I agree that this comment can be dropped.
>=20

All NAND chips have this limitation actually. I guess you can just get
rid of the comment. The rest looks ok.

Thanks, Miqu=C3=A8l
