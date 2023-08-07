Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A2772333
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjHGL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjHGL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:58:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019781BC;
        Mon,  7 Aug 2023 04:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5555E61902;
        Mon,  7 Aug 2023 11:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2930C433C7;
        Mon,  7 Aug 2023 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691409484;
        bh=Jf7kyLbyGJ806axVs2w19112jZ/lnUE8U+gZvgrhBnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/H2xKB0XJqnG4A9MB9Dh7yV+Lt7zmhXpWzPCPrFCN1LKEh3/vwNyqwpxJDZHSTLw
         kFBhJAOdSCF8VsIHTZP0JvIo7HSQbRHaj9ElwHeaQWaaupt54CwPxbnh/7x7+7K7Wt
         JyS+23CrEJRqvjT9fa8i6uRxNK3e+wnw1tq6EdyS1+6Ld1/inwnOKKk4R1oaS+MB+1
         N1jIZBmL9eSnYKZ6nPwWryDd5BQmIn76xdf3MpnbKPwN0etnrVR8ZPrdNDu2a53M/k
         HjviLq2C+nvaGk3KTh4eivK+wQtDuUC9lYaMXZ+oqQD6AbsAmdzd2TfVNKtAcYw3R0
         9DgDQKAJ4Vl9g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Aug 2023 14:58:01 +0300
Message-Id: <CUMAMCVE92I8.2RSIPQM9UJN4C@wks-101042-mac.ad.tuni.fi>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
X-Mailer: aerc 0.15.2
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
 <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
 <CU8WIZGB01DT.2YX12UG6QRTA@seitikki>
 <707e662f-5aed-ef86-a2e3-dda3959d6f7d@cs.kuleuven.be>
 <CUE17WOKP8HH.39KZQV0H8IRBV@seitikki>
 <d3ad2bfb-2d64-73f5-7e37-0119eaa89c93@cs.kuleuven.be>
In-Reply-To: <d3ad2bfb-2d64-73f5-7e37-0119eaa89c93@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 7, 2023 at 9:06 AM EEST, Jo Van Bulck wrote:
> On 28.07.23 20:54, Jarkko Sakkinen wrote
> > It should be relatively easy to relicense the code as most of the
> > commits have Intel copyright.
> >=20
> > Personally I would not mind because that would give opportunity for
> > code that I wrote to have a wider audience but it needs to be forked
> > with some other license first.
>
> > I support also the idea of refining the selftest as a run-time, which
> > could perhaps consist of the following steps:
> >=20
> > 1. Create a repository of the self-compiling selftest with GPLv2. You
> >    could add also AUTHORS file for the initial content by crawling this
> >    data from the git log.
> > 2. Create a commit with sob's from the required stakeholders, which
> >    changes the license to something more appropriate, and get the
> >    sob's with some process.
>
> Thank you Jarkko, appreciated! I plan to start working on the fork from=
=20
> next month onwards. However, I think GPL would be the best license for=20
> this project and I'd prefer to stick to it for the time being.
>
> Best,
> Jo

Ask from me permission when you have things moving forward, and I'll
very likely give permission to all my post-Intel contributions, which
are not that many.

PS. You can quite easily get full authors list with some git magic so
pretty easy to keep things legal wise in shape.

BR, Jarkko
