Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5377EADF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346214AbjHPUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbjHPUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAE2708;
        Wed, 16 Aug 2023 13:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5950F65EBF;
        Wed, 16 Aug 2023 20:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ABAC433CB;
        Wed, 16 Aug 2023 20:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692218391;
        bh=pmS072dZEXt7YatJuOVq8UqswY8UVjXioO/Tl6j94hI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Ndp5yslugLgNMsZ3gI1USpmyqKuTZmSCb0FOq8KYq51JzeLxWEGnvnPN9a7FkbXNL
         5oQExC/vjCdeFNyRRTxK09I52JFBXMO7ONerYunqggyERKaT6ZtJcSiijFZr72C4Eu
         aq68W3f7OM9SDRQWAaiOicn8HfDNEKPkl2GL89u4f8RznR0YlkrOkLbhWWu0rGzv1R
         C7LkLJqNRI4lvEy+NKi2W9BYVqBugJxx7JTo2aTk3Ak2X61QL8TVcTY4hjFdKfikWi
         LlFavGGdogSNgJJxRX/gBhK/4iJssplcZ2ZCawGPllvM9uxJdJd8CWAYq0I43DE9eR
         pi1Z3/I3ao5TA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 16 Aug 2023 23:39:46 +0300
Message-Id: <CUU9CQLZO8CU.2HZ1AA137CA2E@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
        <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
        <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v2 02/13] integrity: Introduce a digest cache
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
X-Mailer: aerc 0.14.0
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
 <20230812104616.2190095-3-roberto.sassu@huaweicloud.com>
 <CUSFHQGJ3I8F.WBL3ZYT3U5FB@suppilovahvero>
 <84159dc8-d2e5-4c10-9910-b329500862e0@huaweicloud.com>
In-Reply-To: <84159dc8-d2e5-4c10-9910-b329500862e0@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 16, 2023 at 11:21 AM EEST, Roberto Sassu wrote:
> On 8/14/2023 7:03 PM, Jarkko Sakkinen wrote:
> > On Sat Aug 12, 2023 at 1:46 PM EEST, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Introduce the digest cache, a structure holding a hash table of digest=
s,
> >> extracted from a digest list. Its pointer is stored in the iint of the
> >=20
> > What is iint? I honestly don't know what it is. I first thought that it
> > was "int" typoed.
>
> Ops. It is the integrity_iint_cache structure, to retain the=20
> integrity-specific state of an inode. Will explain that in the next versi=
on.

OK, cool!

> Thanks
>
> Roberto

BR, Jarkko

