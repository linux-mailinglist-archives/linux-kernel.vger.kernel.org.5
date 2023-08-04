Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A827706A2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjHDREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjHDREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:04:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D03C25
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:04:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so1771438b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691168664; x=1691773464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1MmhfCyIZOMeEDhOtD79SfGRR9Q8WxTvEMHrGhC5Kc=;
        b=CQfAd66BEqD2M6IXbd0tb3aW2XwoH/AfR5J8Poz90mZ4Xnhz3x5iRLOf2f0tfg6Ru+
         2lJ4vxmAsSME+f3VvopAdVAiP2u5OjWYRF77D5lRyvyZuTn8zxhh6rHOjGP6lLzSWxhO
         1C6i9MiOzqrKnKSKXD2b2TM62n6LOQ3ZU11mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168664; x=1691773464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1MmhfCyIZOMeEDhOtD79SfGRR9Q8WxTvEMHrGhC5Kc=;
        b=d1z16WLHyQSjHOn5bPUXKrCJmpIhg3ND3pvvCZ8Lw9JBSYFEarnmtbpEHuBUlxG0Uo
         nK7hxUaDuNOIRjEVnVJfwEhd4rwKEoaZOz8HtU6zyR2MfrPFQqkIDWnzjlC9kiUdBYN5
         iDhZxTkDagCNoeK+oyx287jYSNX7AwjQiOJu8FrBhP6K1ktU4GXhl8810tRnRvjJ6mTB
         ia7Mtnp0hLWAYSCTbdr89RaZKoAHbssnTUIp1Zy/SiL6H+v/Jm6g+PVeZSnA532n9WRc
         Pe609sb7gMDcJmU35gOMdNzn0RZhpX8L8H/05oME9JBojIdzF0JZgJgKr9IJVaXBiv4u
         w6JQ==
X-Gm-Message-State: AOJu0YyndEA9DV/MLkJaOc2uVdakhj/5oDio0saMh8IdKLxD2QZ33fOL
        rGarvPHT/qiPG8UfDxMxEeqeOw==
X-Google-Smtp-Source: AGHT+IGFsLzjoZ8QgB27YeRUt3NtJPg5ijrZzMbtYVDLPRLF/WCsZUPMUzhTW05cNwdmyDgiIvR5vw==
X-Received: by 2002:a05:6a00:1a12:b0:687:472f:5150 with SMTP id g18-20020a056a001a1200b00687472f5150mr2614887pfv.8.1691168664306;
        Fri, 04 Aug 2023 10:04:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b00682562bf477sm1814165pfn.82.2023.08.04.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:04:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     tony.luck@intel.com, gpiccoli@igalia.com, joel@joelfernandes.org,
        enlin.mu@unisoc.com, Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, enlinmu@gmail.com,
        yunlong.xing23@gmail.com
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the initialization phase of the pstore
Date:   Fri,  4 Aug 2023 10:04:14 -0700
Message-Id: <169116865197.3054577.11464864173886707392.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 14:04:32 +0800, Yunlong Xing wrote:
> The commit 30696378f68a("pstore/ram: Do not treat empty buffers as valid")
> would introduce the following issue:
> 
> When finding the buffer_size is zero, it would return directly.However, at
> the same time, if the buffer's start is a illegal value, the others would
> panic if access the buffer.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Check member of buffers during the initialization phase of the pstore
      https://git.kernel.org/kees/c/fe8c3623ab06

Take care,

-- 
Kees Cook

