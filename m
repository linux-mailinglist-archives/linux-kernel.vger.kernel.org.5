Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06673754805
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGOJpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGOJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:45:01 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9331635A2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689414296;
        bh=ZONAthFr+ye2k1eUfPYC4LS9Wsbe2T52otZmFe3uvms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=By6T3qbXid/1MmTqAeuN4fWAmLBYElcwSNIW77GjM3GIbxGblLWwlZNdbtqOWnik/
         H5Mx9Mx/HeCtnUpnw27TXErD+Z0mwEdteOQA9c/z7wA+TWMNdBkFm7VZ0Mfwn6SgGO
         3BsAR2dGry2G/MP0mhOo6Q+sMi9kX7J0zZdKvSvY=
Received: from localhost.localdomain ([220.243.191.12])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id B361F435; Sat, 15 Jul 2023 17:44:54 +0800
X-QQ-mid: xmsmtpt1689414294tq60gmgma
Message-ID: <tencent_0EDE0D522DF8161358B80786820BAAA5C406@qq.com>
X-QQ-XMAILINFO: OR+iMM9v9RFuam7z+5bGLLUDhzWJebHyzAW9QR87s+VYiuWo1jPZNEDt9B30Hq
         US5rCS7a5QURVijig1ubrm9WrctNAR7Jzwi1oBuzEqUuXi6KKjZTLjqaoK7Tdt7Tl7ipit711gcd
         6Rm/u78HzOL2RzAwJES4g4xB5B4bYa/QGlO+Qn6sbV6lCRujHkjG3mAbvs85NfddynzxZfwHR8+f
         MuAGLlCwyLrO8BwrYThGcjGvZ3jCbofEhGZTD+fjPc7NF0TkjprKZx16BkeWKvDZGKpgXzlxfEp/
         1DjP4LicyGg2It8IUD2CZijtyDouYc77JKA5n9NXCTRWuJMv8xIHB3cQUm4NWzTI8ApzUkjTvYod
         8/2mccUuehIg7DhbyanxrOTfdkG/p4tYgTJBA7AqZrkrmUCV1Mnugo7VdZdjaDmp+zZTJBOWraGQ
         yoc/OPDg0WCL++f4wi6MTeIbaqTrJCSl0uNxCaBCXJLFZFmr7a7yFnh4NBEwXGG3Fp/xSVQXQgVF
         rAQJph/nHSvpMvl69gxq+yzju9pV1HAwbUQwDSigAnCJzmJBiq3/EvnQ6DkpEEOJRIso9mbURi0J
         6UP/h4xYrR+f+fc6zCi4o+w8slr4iD41bqwsJeHrBWr2q5OhQ+r9nkU0YUeyRpjs4cXcnBB9JaX7
         bhyodnFJ1igKhQWNf0c/8XKZ16TXxICT8OkI2kvaMpgpa4NFNL8Lt+aQg0TbK2XK2SqjGPrxfv5f
         JC/zlcTin7HIXLylaBRJl342GWAM183MCOdrh8jladKdx7eOPHHInaFZIbz/uM3qp6+tgqFGV5dc
         gszsdnbhj+CmsCJWHHkGpTGrX8yCLmQqlS8qKWpgwZRB8uI3ck0BVk+Q9LYWVZvGvcCm9AvI8RfA
         9ibqKjqAXGXVOqx/oZH0/QB3zB/AKVeDaF15ouxUaEphREz55gnjMnqbPLIb1NbNB1mdyjCH4wf7
         RGYj4OMxNj0nI2wO1NHGpPVfNOIQMvyV+x94DdmuezshO14bsd2WMw8COedvNF8I4kmmjvc28=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md: fix potential OOB in multipath_remove_disk()
Date:   Sat, 15 Jul 2023 17:44:53 +0800
X-OQ-MSGID: <5697119.DvuYhMxLoT@localhost.localdomain>
In-Reply-To: <ZK7Zy2U86znezl+a@infradead.org>
References: <tencent_E2C71605D88087940237AA9A44CC8D436D06@qq.com>
 <ZK7Zy2U86znezl+a@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B47=E6=9C=8813=E6=97=A5=E6=98=9F=E6=9C=9F=E5=9B=9B CST=
 =E4=B8=8A=E5=8D=8812:50:19=EF=BC=8CChristoph Hellwig =E5=86=99=E9=81=93=EF=
=BC=9A
> On Thu, Jul 13, 2023 at 12:46:05AM +0800, Zhang Shurong wrote:
> > If rddev->raid_disk is greater than mddev->raid_disks, there will be
> > an out-of-bounds in multipath_remove_disk. We have already found
> > similar reports as follows:
> >=20
> > 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
> > 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_dis=
k")
> >=20
> > Fix this bug by checking whether the "number" variable is
> > valid.
>=20
> I think it might just be time to finally dropped the deprecated md
> multipath code instead..
Should I write another patch to delete them?



