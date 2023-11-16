Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEEB7EE972
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjKPWnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjKPWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:43:42 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A020127
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:43:39 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35937f2fadeso5183405ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700174618; x=1700779418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRSdf0PEURr52X1uXRfTSODl32tTGq0g+hPl3iixuKU=;
        b=kRK58Dxuku5gIG5lqbmrAlcKOjNuPZy+lL7p61LJHk7ekfJ+y/7zLsSFENnA8azp2K
         ktMv6swUoTmPX/1rtsE8TyAyV4f7Ut/6+XNS2nEbgKh7YEkF2BKq9KblQCGweys5SEjK
         B7GvcXsq8DM5LFlbAc6rlpxZ5u0azQubbaKNI3wBmWu3zyKCm2cRJvH4Joqsxgru6Eho
         v8C8RRsYTbLe8UjDgDEIFmRZ7Hr0TU/TCGX3gqZhRg5GEDZ8kcslxi1uuSTK4qpjN7vo
         e6bKUf/D1YCmPOuMlur9w/NztQt1RszYbdaehUrA5MdO4AmyrcwSX5dqbsQOIp9NXatJ
         UxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700174618; x=1700779418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRSdf0PEURr52X1uXRfTSODl32tTGq0g+hPl3iixuKU=;
        b=OgrT2pVIPjzrxxK1dyj7XLP/fqTlDrVh4EdwofdoXtS5sms/ffRZCSu151X+WZuIce
         +XwyoAIYDWP+HA5fETZ0FnusHhjD15ftqCrA59u3OFwe4w8wh2vJoVdQiz6kB2Yl+A7J
         SOKEqEbt7Jcr8GpqxAWtyIDlQS+e2hOoeRQ9qkWpstN8Tl7buyggAVfL1EoRA+zEc20j
         L50WFqxkOGPhikvBRX8MTAT7o0coaF1eeew41j6mdSize6EMDEZyrjVpKjfiO4d4Ys81
         B7vhlzO+vIMKSLmXIrRxcFTKTL8c3HgNoiYGNAA9jxKT4zdGFleTHUZ1KWNC8O1Ubaqp
         pDaA==
X-Gm-Message-State: AOJu0YxDHTcH0FbuBEj65642inlS3MT2awmwxBvtY/DSKXCPuveMVRWd
        g1TnuL+90/YhP7td+S4yKikBg1SEzyU=
X-Google-Smtp-Source: AGHT+IFY5T2VId263D9I7FpGHlujSaVQR/tfdr+TK49fVfif1WrE570kvXTBFzA4d5KztzT4ADj8OA==
X-Received: by 2002:a05:6e02:214b:b0:359:4048:38df with SMTP id d11-20020a056e02214b00b00359404838dfmr19126254ilv.7.1700174618307;
        Thu, 16 Nov 2023 14:43:38 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id g12-20020a92520c000000b0035913c8423esm84399ilb.73.2023.11.16.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 14:43:37 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] tweak kmemleak report format
Date:   Thu, 16 Nov 2023 15:43:16 -0700
Message-ID: <20231116224318.124209-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 patches make minor changes to the report:

1st strips "age <increasing>" from output.  This makes the output
idempotent; unchanging until a new leak is reported.

2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
user see repeats without actually reading the whole backtrace.  So now
the backtrace line looks like this:

  backtrace (ck 603070071):

I surveyed for un-wanted effects upon users:

Syzkaller parses kmemleak in executor/common_linux.h:
static void check_leaks(char** frames, int nframes)

It just counts occurrences of "unreferenced object", specifically it
does not look for "age", nor would it choke on "crc" being added.

github has 3 repos with "kmemleak" mentioned, all are moribund.
gitlab has 0 hits on "kmemleak".


Jim Cromie (2):
  kmemleak: drop (age <increasing>) from leak record
  kmemleak: add checksum to backtrace report

 mm/kmemleak.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.41.0

