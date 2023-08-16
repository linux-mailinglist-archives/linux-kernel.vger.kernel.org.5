Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A777E77DBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbjHPIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbjHPIFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:05:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291DE2710
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:05:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf3f59905so825288766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692173119; x=1692777919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvdVBocTF3g82OdbrW1329iCJNDsO6RbmMm+mRrv4jM=;
        b=FAifJtLCb7k6UxvB4wQioo15Zy3SJO9y0ggCGvixx4OaWlavjkvPjeLGAGIP4DLx8r
         wi+5c7M9kvPr8BKBCRQbJByB7rpEkXzG1Y3axJa/Lt4PcAwRZQhoPd4DfnJfcio87QP/
         KDUQUuCjT3Q498xn/TtYisguaMITjFhaf+CJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173119; x=1692777919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvdVBocTF3g82OdbrW1329iCJNDsO6RbmMm+mRrv4jM=;
        b=FAzUX8s5+vC1SFlK12ujNKTrOSZiGIEHcBhxLj1VzwOZALoIJnbIsj5ZUKi+SI4ubr
         Qq4zKX77VodYrMEqSVpzHP2O+paVz42xorwCHzFvKNDtTBjme+IJyX53cJR8gXHD+cSN
         3rOceITxgkG/hk1FqP1m2ulaoNHoFNHqLSam6mJzg9HcR/MZ6AAEcLUK6qSmfW4BlRDD
         GjBysrth/fXLNnS4PCJltfqT0BFmyG7ikFtR9BirMn57xxDNSFO2j6ptGkLpI+HwVqtD
         tcWeibB3+Hdg6TZK5y7dhycmVcOi723mVudFqOErgOSKsnqcIsSfxn1KQXT6ZiMUzXEE
         9mjg==
X-Gm-Message-State: AOJu0Yyti8YS7b0ncsPPHW0eMxEQFwB62lfgb/vwiTE7YqqJb3h+vdbJ
        qO6vS0Bmyn2J81qiQtQV1n9MQKodQ2QfrHpcpLGEsQ==
X-Google-Smtp-Source: AGHT+IFQRdhEhXVXFZy1tOAt7zLwCmVCjGMzpQKaXqJKHb+Wy/2fovO0+2JhzK9GXQneeiD0x9EU97yIUu+SAXiZPrk=
X-Received: by 2002:a17:906:5195:b0:99d:f6e9:1cf8 with SMTP id
 y21-20020a170906519500b0099df6e91cf8mr355025ejk.20.1692173119472; Wed, 16 Aug
 2023 01:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtjQxPd-nncaf+7pvowSJHx+2mLgOZBJuCLXetnSCuqog@mail.gmail.com>
 <202308110712.37B7CIwo078462@mse-fl2.zte.com.cn>
In-Reply-To: <202308110712.37B7CIwo078462@mse-fl2.zte.com.cn>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Aug 2023 10:05:08 +0200
Message-ID: <CAJfpegtrmm=+9QkQoQm3t2=GjcwTEAcmCt_ChLkXjn9Bg7M_UA@mail.gmail.com>
Subject: Re:  [PATCH] nlookup missing decrement in fuse_direntplus_link
To:     ruan.meisi@zte.com.cn
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 09:12, <ruan.meisi@zte.com.cn> wrote:
>
> From 53aad83672123dbe01bcef9f9026becc4e93ee9f Mon Sep 17 00:00:00 2001
> From: ruanmeisi <ruan.meisi@zte.com.cn>
> Date: Tue, 25 Apr 2023 19:13:54 +0800
> Subject: [PATCH] nlookup missing decrement in fuse_direntplus_link
>
> During our debugging of glusterfs, we found an Assertion
> failed error: inode_lookup >= nlookup, which was caused by the
> nlookup value in the kernel being greater than that in the FUSE
> file system.The issue was introduced by fuse_direntplus_link,
> where in the function, fuse_iget increments nlookup, and if
> d_splice_alias returns failure, fuse_direntplus_link returns
> failure without decrementing nlookup
> https://github.com/gluster/glusterfs/pull/4081
>
> Signed-off-by: ruanmeisi <ruan.meisi@zte.com.cn>

Applied, thanks.

Miklos
