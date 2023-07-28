Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA2766E90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbjG1NjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjG1NjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:39:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B6FC;
        Fri, 28 Jul 2023 06:39:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so23580125e9.1;
        Fri, 28 Jul 2023 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690551560; x=1691156360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luuurpFFHIk4Z1YcDdA8iq3kiu+yWaoiyG/BO1MOdDU=;
        b=U9VxHz8ienoheJCcgcipsYjMczfL9Xbps3Q10DCmbJFBGNuvuK156BNEKRkIAaw9lc
         s3ULqDTwE4quIGvSbxiZWExzSlh/999oK7gTI4aikAqEu9ZsFdCRs+qB54k8JKpwS004
         u8xHfqb7hac57pNbLJ2hsylfxQr4JTZXVOHA3jPhyqADYJwfOJCe3THGpCTb+oxjiKcI
         39Dl95rLpoWDXnUopDH47j2YIrhEaSttjOIZH5UZ2OWMN6mVFSLQaJDxuTGye1JIERg6
         /bYJV4UOwZyx81lCkJZ7rcxeu29EfVuGnNoljPodJ8ATwOCvGPq//7DirqgSDhosI0sP
         4xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690551560; x=1691156360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luuurpFFHIk4Z1YcDdA8iq3kiu+yWaoiyG/BO1MOdDU=;
        b=aGS2w+GBvg5IeuHefsK1lNsTYptacdLucqh7h+THwxqHXGJaDpwvXXFpeCEG9b0c5x
         QfjLHMwSXeINdZhfqg+8qXAqqW/8LYqAXO+C2WA3hV+K7Ur4nfGax8EzBEJWEW7j36Oi
         q0gn8YGMWbnbDQ/Mvda+/W+49u1NlyiAnKkhsUR48NnoxTdlfrdUzhA+bWpf5HCA/Z1F
         cKfYayqBP1H2UuG3zVp8wvMqXpu6HIXFTuu425mtKLZH3r7U58Yl1ChcqRNZ1Vt3qtDi
         ZkNL0SnsyrYM2LWEO4ZdYNheSg5GHWp29MUK1PnBEaZBlgTihRriwjObs7grNGB7X/H0
         AQ9g==
X-Gm-Message-State: ABy/qLbn44wNUvGizkMfkmWPmzM27LcCU3C06GgeO8mM4bvq3zmuLXGH
        PuH05k9lbVHvUPgfYZCWyNM=
X-Google-Smtp-Source: APBJJlFJE6u62rT4aWCp1taQAzPphe3a+55s2pVgaakYzFN+g+mDCYK1kVpqsKhjTEHHZFAdUzOJPQ==
X-Received: by 2002:a7b:c354:0:b0:3fb:e2af:49f6 with SMTP id l20-20020a7bc354000000b003fbe2af49f6mr1538596wmj.39.1690551559839;
        Fri, 28 Jul 2023 06:39:19 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm4294463wmh.14.2023.07.28.06.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:39:19 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     bbara93@gmail.com, benjamin.bara@skidata.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ads7846 - don't set ABS_PRESSURE when min == max
Date:   Fri, 28 Jul 2023 15:38:59 +0200
Message-Id: <20230728133859.3808994-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZMLV9BVxHx3jlE5R@google.com>
References: <ZMLV9BVxHx3jlE5R@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

thank you for the feedback!

On Thu, 27 Jul 2023 at 22:39, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Jul 27, 2023 at 05:19:57PM +0200, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > When the optional fields "pressure_min" and "pressure_max" are not set,
> > both fall back to 0, which results to the following libinput error:
> >
> > ADS7846 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE
> >
> > Avoid it by only setting ABS_PRESSURE if the values differ.
>
> What is the benefit of silently continuing without reporting pressure on
> models that do support pressure readings, vs. using libinput's errors as
> signal to adjust DT?

With the current implementation, libinput rejects the device [1] when an
optional device-tree field is not set, which leads to a "non-functional" device.
But you are right, silently continuing might also not be the best option...
I could provide a v2 where the maximum is set to a fallback value (~0) and a
warning is printed that the pressure is not set and therefore a fallback value
is used, to signal the user to adjust the DT.

What do you think about that?

Best regards
Benjamin

[1] https://gitlab.freedesktop.org/libinput/libinput/-/blob/1.23.0/src/evdev.c?ref_type=tags#L1816
