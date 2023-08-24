Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8AE787503
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbjHXQPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbjHXQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:15:28 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C6119A8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:15:27 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-48d0ae408b8so24477e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692893726; x=1693498526;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+hQDMYVgI0vCj98x6QYkVLqKPtNdIJJcCaziDcgPvbo=;
        b=KpCa81sDxzq5tlaPqZ6oaoYtJdCskueVDUni15PrmztzF8UyBpkkUhSUpltVpLCPOc
         ce/+rRD7G9MEzv6xQB7aKBNxiGUt7SEhG4nx67Fmp0ivdorFJaTT8fmBHOhIKdCsQcQW
         J0RrwYWuYu1cOniAnas78InKX2NxZEBU0vk4S91Q/r9HBL5kXCEsfUq57BamlMVxvFkY
         NVX9MaXCcL2FKWcH0LjjjYOpbUa7mILsnKvgocTEOyD76y+gpc/daXGorsS8XHXUXwIn
         BLd2cUcxZ4BMTJ49T8N5x8MguBa41pPId7olv9huS+IWYZFx3anx0UEnC3AShm1kB2t0
         GMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692893726; x=1693498526;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hQDMYVgI0vCj98x6QYkVLqKPtNdIJJcCaziDcgPvbo=;
        b=NssLqh8Jb1kHjDpHDXrKB2JCcGFNocaXmdBo6qiEsTc7OJWNT5jqgf8dofn2xXLwP7
         1ojQq9jj7PcW2ZKIwHN6jJvkS65Fn5x1e4K/6J7MnSfBfneF2em/i1zWcu9o2PrF196M
         lCENXsrA2+AS/5knOZR6aNIqReAaMMk5RzngWGtFoVhZuyGn+Kk8/JRkDN0i8yvBwYqX
         hKXtCeMuKDCHk3CXOSPixqItk7gasy0afA8xf0c9GQrm86xDu3SYAyDlXrnM/2czO2XI
         H3U7Ad+qwL2dNmjK4Wl2NFI+nyhp1/EC/8x5uFyb8bK7DvPWbQLbSkGuKEhog2Md3tI5
         V4Mg==
X-Gm-Message-State: AOJu0Yw69ogP7/91pKfYofuEAF9XgePGc+wWTWgX76uRqzoiBEHz7GNN
        Rl6Lfz8M7eEG2NoCwMjgVdSGWRA5fGmri7++M5m+4/cR
X-Google-Smtp-Source: AGHT+IEU0HJok+/Pc+6pMyqzmTheRALySQqy5JfvXYG/NBlgbR3Vi72PJxHpSWV/OMWMK9AxXMcmG69vhVdLrLQugdQ=
X-Received: by 2002:a1f:9c0a:0:b0:48d:1049:ed06 with SMTP id
 f10-20020a1f9c0a000000b0048d1049ed06mr12005935vke.14.1692893725989; Thu, 24
 Aug 2023 09:15:25 -0700 (PDT)
MIME-Version: 1.0
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Thu, 24 Aug 2023 09:15:15 -0700
Message-ID: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
Subject: System Call trashing registers
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) A lot of my old 32-bit programs don't work on x64 linux anymore
because int 80h now trashes ecx and edx. This hasn't been a serious
problem for me.

2) syscall is documented to trash rcx and r11.

What I don't understand is why this hasn't ever led to a security
issue due to leaking values from kernel space (in the trashed
registers) back to userspace.
