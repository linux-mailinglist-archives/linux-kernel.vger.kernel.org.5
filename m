Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0C77C133
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjHNUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjHNUBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:01:15 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A8A10F4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:01:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a3efebcc24so4015485b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692043274; x=1692648074;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLx81HjNMcdtjBPAf501FIttTYshdXsh2VkIYyL/jUk=;
        b=4RoK/TMueeUlc/+s9Wek0k+/0CReAWcvMe0a4D5ry8OTkcRIgoMFS8dfWNnovi+FtR
         aJsfh9FwCR6j5RC19LnxdYiuTwFPA9pGlH+NJafKbwqmH7Kjhc623dr+IBKRmesHMsqf
         VX6gFd1D6D3rmlQuoOZUP6jSw6QGNv5W7M2kyjvQ0PbXuJJKCDM3Dc3zeVQal+DomuHr
         ODih3LQ911QDnFCxbyzjK7K53OHt7TyrTe+TekyFUl1l0tkiwET7UVSvkUiGx/Pt7jif
         KQX/pdi4bt9vWNJ4Ub7KdNvxXfAUUzLa2F08+YErUqc5iQxfwTByG+Oy1oTg39KZW/PI
         3Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043274; x=1692648074;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLx81HjNMcdtjBPAf501FIttTYshdXsh2VkIYyL/jUk=;
        b=IGSBkwYshW2+PvWno4WwI+GphoXPSYH6x/TkByeuv5rK4WuBh8z7WyIoJN72RoxBIg
         /jqOtwauACyOAgH/U2zS8BvROuOMqUJw2IiGDS1zOuYJ3Wfxh2PFxYeu9eD6JpTyVJdM
         QM4LUjV581Vm48sYsuXYclCxw+nSSaiMuTzlyDSE4RFPfrbXOq3irrFl/r7cNqMSa/vq
         h0L/b0zlXpLYLjjJFtQ0WHeFByik9KCZ30cjHImoBvxtfgeae+VGVxCBNpU/9IadC+SO
         JM5J5Zqv8tJIpuVBRBb2PtBaq+j7IppNdoAPhJn8mA3Z/B+5wIoEUIHgkwvNdTm56Asc
         UPiw==
X-Gm-Message-State: AOJu0Yy56rAhBwCkvckSzy1J9QO3eoUEtFNtr4PDZG7fJF48DqzYoY8B
        x7Akhz3iKaJHoDbziFIUbupQjA==
X-Google-Smtp-Source: AGHT+IHJsw2JK75MRC3bpiMwlKdGt/SDygzWF4moEUm3RhHfFPnMbvc6mpdlGUzicghlzenU7k4mkQ==
X-Received: by 2002:a05:6870:971f:b0:1bb:b337:fdc7 with SMTP id n31-20020a056870971f00b001bbb337fdc7mr11678733oaq.59.1692043274049;
        Mon, 14 Aug 2023 13:01:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y6-20020a818806000000b0057736c436f1sm2961902ywf.141.2023.08.14.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:01:13 -0700 (PDT)
Date:   Mon, 14 Aug 2023 13:01:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/3] mm,thp: fix nodeN/meminfo output alignment
In-Reply-To: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
Message-ID: <be861b50-a790-e041-bcb0-2a987dcfd1a@google.com>
References: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one more space to FileHugePages and FilePmdMapped, so the output
is aligned with other rows in /sys/devices/system/node/nodeN/meminfo.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 drivers/base/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 9de524e56307..8e871ba9162f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -446,8 +446,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d AnonHugePages:  %8lu kB\n"
 			     "Node %d ShmemHugePages: %8lu kB\n"
 			     "Node %d ShmemPmdMapped: %8lu kB\n"
-			     "Node %d FileHugePages: %8lu kB\n"
-			     "Node %d FilePmdMapped: %8lu kB\n"
+			     "Node %d FileHugePages:  %8lu kB\n"
+			     "Node %d FilePmdMapped:  %8lu kB\n"
 #endif
 #ifdef CONFIG_UNACCEPTED_MEMORY
 			     "Node %d Unaccepted:     %8lu kB\n"
-- 
2.35.3

