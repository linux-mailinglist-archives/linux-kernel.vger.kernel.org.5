Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D6E77FCCD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353838AbjHQROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353955AbjHQROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:14:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACFFC7;
        Thu, 17 Aug 2023 10:14:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so935395e9.2;
        Thu, 17 Aug 2023 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692292439; x=1692897239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85RG1IQDCuJNPwO75SESXd9ST6ItDDNcZ6gNupY4ewQ=;
        b=ZJsTIEz8qzCfzH+4ophjAnZMPI9k2YyQShDoPCXDzdNA8rpGSf9EnSbRplmvflTCx4
         eNMlj7gX0H82dDp2FcPoLB6yG+4AWfCJdRe27w6TEGS72uF4a2z+q1rtk5bl4PM5XbVH
         +T573fAQn4YHr8bTHL+tziSe3N0dZ+uQzWI9c1bz+ZwdAmw/EWKn9V2JGG+F0HRSGwRE
         gwqqHu1lO/v0YllzQfPIbpvnAViHdFA/E2O6KyFsCZXUJdCNpZvlpGELG5QPrSbXV45V
         lAdPiBSruBQ7rqtHgFEpxAYFBu5/uignfCPi3xYW9IDWZyDaWJ9qX52d9DoA7eQXh3CI
         qOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292439; x=1692897239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85RG1IQDCuJNPwO75SESXd9ST6ItDDNcZ6gNupY4ewQ=;
        b=WjFfx1aFuL9x3QQ94gz5TZYoYPlEUp8HSdjcr4pLwcdXplGGaCnr7x4HLRPA2ByYm8
         JMjKdgojxHODwbLxUKTJAgQztMTpt4KgDxXwgcjqyf9HSrqIP9UI/YNbVRylSr2rndvu
         w8LhvrgpEKnujHrACoVvf0HZBGsQGDVwBsCzgKseS+LHu23O9mPCi6CbDw0AVBQE74IO
         8b5qY0A6S5ynFS9uhXND/EhDAoi9sPQv0rKmAOEUaImrmn39cFcbAWMms3WzGmpK/iES
         EBHutXeX49kwHluson6ef+QJWUkljtSSOOYs3cA+hMcpk1xhxzQxkJU9XFrq5QBSQsAK
         W/tw==
X-Gm-Message-State: AOJu0YzQPOGkoqROreBLF+Zxe6gqogBNq+Q3klXxQxcUZnSi2XgaBg1y
        05RS9+eouTMyE8AFoeTIMkM=
X-Google-Smtp-Source: AGHT+IE35t6pkWQU434M3WOUg1PLFiGp4fjHGQYaTrvP82ETRP6AEMMbhuSmYCAc4I+22U7ANwtGHg==
X-Received: by 2002:a7b:c8cd:0:b0:3fb:dd5d:76b with SMTP id f13-20020a7bc8cd000000b003fbdd5d076bmr298234wml.7.1692292438881;
        Thu, 17 Aug 2023 10:13:58 -0700 (PDT)
Received: from suse.localnet (host-79-56-101-183.retail.telecomitalia.it. [79.56.101.183])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c028500b003fe505319ffsm3606627wmk.18.2023.08.17.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:13:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with
 kmap_local_page()
Date:   Thu, 17 Aug 2023 19:13:56 +0200
Message-ID: <4506725.LvFx2qVVIh@suse>
In-Reply-To: <20230630-umfang-pumpt-a0cd2d6cdd91@brauner>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
 <20230630-umfang-pumpt-a0cd2d6cdd91@brauner>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 30 giugno 2023 10:45:17 CEST Christian Brauner wrote:
> On Wed, 26 Apr 2023 19:22:20 +0200, Fabio M. De Francesco wrote:
> > kmap() and kmap_atomic() have been deprecated in favor of
> > kmap_local_page().
> >=20
> > Therefore, replace kmap() and kmap_atomic() with kmap_local_page().
> >=20
> > Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> > HIGHMEM64GB enabled.
> >=20
> > [...]
>=20
> Picking this up. Please tell me if this should be routed somewhere else.
> vfs.misc will be rebased once v6.5-rc1 is released.

Christian,

v6.5-rc1 has been released since a while, but I can't yet see this series. =
Are=20
there problems with these patches that stop their merge?

Looking forward for your reply.

Thanks,

=46abio

>=20
> ---
>=20
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>=20
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>=20
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>=20
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>=20
> [1/3] fs/ecryptfs: Replace kmap() with kmap_local_page()
>       https://git.kernel.org/vfs/vfs/c/7a367455b6a5
> [2/3] fs/ecryptfs: Use kmap_local_page() in ecryptfs_write()
>       https://git.kernel.org/vfs/vfs/c/55f13011af9d
> [3/3] fs/ecryptfs: Use kmap_local_page() in copy_up_encrypted_with_header=
()
>       https://git.kernel.org/vfs/vfs/c/de9f5a15080f




