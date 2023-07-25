Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B0760B27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGYHHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjGYHHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:07:11 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA783
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:07:10 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-765ae938b1bso470382185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690268830; x=1690873630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPXbPq7UJNuXZs4NkhlcqVblqJBzPRRpcv9Sz5K3wL8=;
        b=l8gMKYbquK7SXf1tgwe8R46+d2a9kE3r2Ch9uI66c/i1NUBEVmpreuPonDOu27qjCT
         2mIIGBBb3KcL2FxekF3ekrUrQNyyOwNCwOYWNZbvKYepwvwXJhiHVSX9bROIylz4wn0a
         57qBgnVSD/SVfC0HRDKMHKwkqIfwiaDMiwqUk1LDs8guHvuWwKey+C+XN7C35hQYssL7
         Ir+ylxCKYZUL5vLwW+sH4CpqIfxFsB3Npx2+128J+V9x9nkbPrrqkz1OS+SqP/7KEKZT
         66CldQy27RsSHChLZXfN6Wk/6kk6CnWlYEZYg+hdSu0alAa3e8YshcoL3MtENEJTCgGg
         FPng==
X-Gm-Message-State: ABy/qLbF1h98+AqpWMr6cSFK1m1sBAu5MSpSMX2l/kwMLf7QugrK5Kje
        6l3//G4q4zCq3b6jtWc1eTA=
X-Google-Smtp-Source: APBJJlGofnfpfblIMruD6U7HysQ/9ZJ95Oeh15FgTiSrpCPdr39WK+gEspDRgyVOSQK6ryIhW7ay9g==
X-Received: by 2002:a05:620a:318b:b0:76a:dad9:8889 with SMTP id bi11-20020a05620a318b00b0076adad98889mr2441772qkb.43.1690268829790;
        Tue, 25 Jul 2023 00:07:09 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id p9-20020a05620a112900b00767b24f68edsm3504384qkk.62.2023.07.25.00.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:07:09 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] get_maintainer: strip long text in brackets from mail description
Date:   Tue, 25 Jul 2023 10:06:42 +0300
Message-ID: <20230725070642.2270207-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assuming this text is optional,
because truncated bracket causes error of git send-email:

git send-email --to-cmd=get_maintainer.pl ....
Unmatched () '(open list:CXLFLASH (IBM Coherent Accelerator Processor In...)' '' at /usr/libexec/git-core/git-send-email line 652.
error: unable to extract a valid address from: linux-scsi@vger.kernel.org (open list:CXLFLASH (IBM Coherent Accelerator Processor In...)

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..8319694a9c2f 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1252,6 +1252,7 @@ sub get_subsystem_name {
     my $start = find_starting_index($index);
 
     my $subsystem = $typevalue[$start];
+    $subsystem =~ s/\(....*\)\s*//;
     if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
 	$subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
 	$subsystem =~ s/\s*$//;
-- 
2.41.0

