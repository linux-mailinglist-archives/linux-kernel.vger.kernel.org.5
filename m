Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226927B1211
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjI1F1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1F1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:27:16 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9599DBF;
        Wed, 27 Sep 2023 22:27:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77574dec71bso176575685a.2;
        Wed, 27 Sep 2023 22:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695878834; x=1696483634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91JYLBFnZKjwBEAu9U+5Q6DScQJFvzg48kgHznaCaic=;
        b=Vxb3cF5oB8WYdgLpRGmn+rWMIdwnWtC0pROz4hiCWqX8ShrwzAZ4AXTxlJbFYrRCsE
         epyK4JTs6xChbpLZprc1FcZMa1rRaCnPQiMryYEZLSi4KomdB54NkFrdcpWGND7PxOkV
         81qNd8ELOySLKpD6p652XRDXlgnZEvbFp0+zBawEDCJwoQUNlD7uwMkyWWHzpTQXSMxi
         GEdDsG0+fTfpzVhnua546ZDrESOQx2OhGBcGerJfpOnAP7nTFnW2fkPFdeF9HnrGw0FP
         2trv7aHrdeUlXDRTcscgwSz3zXlcXrr6HSJqgRGhHoxhRHnQnRNC70oE6Hh0w9twlTyf
         gxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695878834; x=1696483634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91JYLBFnZKjwBEAu9U+5Q6DScQJFvzg48kgHznaCaic=;
        b=vkDiDnlp5T0ofzOX3pz7SSTsKBTbIerSYe8+snJdUB2EK7JLxQqxY4QVmv6lFoew+g
         zqvK3paRAH/CKraL0ZPbVrv/uskwSXsEZNXD2HeuGQty1vPb10kXNhGjHSTUnnIggFOF
         n+1OqC5AtX++6RA4zS+IN8TOdcpVNeBon4vfiV1J5n9dXhVokt+qPgXZUxL6QE6RFtOW
         nd27hHtptt8niH3XGUlT4SovqLu+o6ews/NSPM+dp9N9cr2Sb3dXuTwNs/b+Ru8CUgit
         Rm6kpgZHhNaYLV1sEteC+F6X19/l/Hgzes1VBMyC1sfImTVAVw+EVM68wAkqGZT62eWj
         1f1A==
X-Gm-Message-State: AOJu0Yx6LUOinFoZ3/A9jXsgbMTG6zul1O/T87QqJLJkjGznpmx6Le4z
        gKLJwTS9/1vYgQE3aRs77iG/WZgHhIsxnQ==
X-Google-Smtp-Source: AGHT+IEkZPP3pv32NAgX/doGdGgAF10Jop4AHaQfOVU9lByCRXNOAzRIRQHyjL0lMc4c48BrH1lzNw==
X-Received: by 2002:a05:620a:4550:b0:773:a9d4:e7f7 with SMTP id u16-20020a05620a455000b00773a9d4e7f7mr259770qkp.16.1695878834692;
        Wed, 27 Sep 2023 22:27:14 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id br7-20020a056a00440700b00692cb1224casm8458108pfb.183.2023.09.27.22.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 22:27:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7135A819448E; Thu, 28 Sep 2023 12:27:09 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next v2 2/2] Documentation: dpll: wrap DPLL_CMD_PIN_GET output in a code block
Date:   Thu, 28 Sep 2023 12:27:08 +0700
Message-ID: <20230928052708.44820-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928052708.44820-1-bagasdotme@gmail.com>
References: <20230928052708.44820-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=bagasdotme@gmail.com; h=from:subject; bh=NIK+r+umq9T+8ea3aOWEFkLVXITGU0Rtbys6y3sG4jM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmivLH2p9yrmdK+RtUtN8wO2MRhOlH3D8/q59rHXYRdj 27LYyvqKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwESWfGdkaCtiPPyx8vvnjXuv HpLXN9go9nG+uuPVWXGLb6S90XeZUszIMFW27VESn4WocIZazMN3ytd+6K4S6Ky7dyJ8suMvhhN rOAE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPLL_CMD_PIN_GET netlink command output for mux-type pins looks ugly
with normal paragraph formatting. Format it as a code block instead.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/dpll.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 01eb4de867036f..69670deb8c4e09 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -119,19 +119,19 @@ with.
 If a pin was registered with multiple parent pins, they behave like a
 multiple output multiplexer. In this case output of a
 ``DPLL_CMD_PIN_GET`` would contain multiple pin-parent nested
-attributes with current state related to each parent, like:
+attributes with current state related to each parent, like::
 
-'pin': [{{
-  'clock-id': 282574471561216,
-  'module-name': 'ice',
-  'capabilities': 4,
-  'id': 13,
-  'parent-pin': [
-  {'parent-id': 2, 'state': 'connected'},
-  {'parent-id': 3, 'state': 'disconnected'}
-  ],
-  'type': 'synce-eth-port'
-  }}]
+        'pin': [{{
+          'clock-id': 282574471561216,
+          'module-name': 'ice',
+          'capabilities': 4,
+          'id': 13,
+          'parent-pin': [
+          {'parent-id': 2, 'state': 'connected'},
+          {'parent-id': 3, 'state': 'disconnected'}
+          ],
+          'type': 'synce-eth-port'
+          }}]
 
 Only one child pin can provide its signal to the parent MUX-type pin at
 a time, the selection is done by requesting change of a child pin state
-- 
An old man doll... just what I always wanted! - Clara

