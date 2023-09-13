Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4193C79DD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbjIMAX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjIMAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:23:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719F18D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:23:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0d5b16aacso52007595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694564600; x=1695169400; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMa4ESenRbt+40AQIQozWuNk8NwNSRQGuKIsK+XbbO4=;
        b=gcqa1X1K8zLzeGQMPHeputebiTPd4546AEZ3LdpH0fsfqhCxld2ONzLHhjTi3XEtuM
         7j3U5fhqsFjm7RXR2KvB69DEAp68mYiuVNHxNLec3THcnOf7TR2frYF0cmM/yeTCXaUA
         PSuAcPWRcLm6NCS/Kffy4lMZuREo4vdL/QUbP4caZ9dURhGbh4bxK9VdGKCVw1NplqDc
         n3AuCdGx/z0E4udJck2ocFISYKy6SD0zWTwo0K9leHYbAsPnjaxY9NPMDcY7l2GBYjZ7
         Mxersuxf8TCoV+lnI+IJds3YRVAJ61CET1kAKDVemmCTHgl2yG/rjQMvCltyUKh64g2f
         vnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694564600; x=1695169400;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMa4ESenRbt+40AQIQozWuNk8NwNSRQGuKIsK+XbbO4=;
        b=PpZI9mu8PN+CNTcXGEvb7KPTTOvewaJlcMB5wC9jZzIn7JYIcqk/TVj1HEQMEL+rbs
         aWMZr4ykqUlBwvK9cJaL08+0kAIQzk6lzL2h+yAE98ihuyXrwrHu37chLe90EoiZAmf4
         UF8rLbW4rGUzY+rtXX4yLbh7RZ6mGpQ4AYBYcuSUrf7HLDpBwC7JzdnvlFYX72fMZV2w
         XOCF8Zrt5f7l5EcZdJ1a/kdgmkkyfzgMRZjHFg3X46iRR6RDcW6SRxwrMU/7p5zbAT7d
         DyfEmoTwiWIyOaNHAawCgDisRKTshl9dDRe3kdzc6LtVw5l368IU4+5C9nQiqZENfMUl
         V4KQ==
X-Gm-Message-State: AOJu0YwOjOe/8ptoEXkW2VPz0L+59qtyIOKGjvnrQkOeD3aWeBm4EgXR
        0a9wzVOMdGPj10HLWEujSP0N2w==
X-Google-Smtp-Source: AGHT+IGUViDwTFl5mghyMFB4Vn0imacJ0bNU7cEqwkta826DwmeC0XDVnGms2RhzOxGkR8CD4QWdhg==
X-Received: by 2002:a17:902:7c0a:b0:1c3:2ee6:3802 with SMTP id x10-20020a1709027c0a00b001c32ee63802mr1002659pll.47.1694564600255;
        Tue, 12 Sep 2023 17:23:20 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b001c0aa301703sm9057779plb.63.2023.09.12.17.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 17:23:19 -0700 (PDT)
In-Reply-To: <20230906095817.364390-1-songshuaishuai@tinylab.org>
References: <20230906095817.364390-1-songshuaishuai@tinylab.org>
Subject: Re: [PATCH -fixes] riscv: kexec: Align the kexeced kernel entry
Message-Id: <169456458172.23158.6375457839178821869.b4-ty@rivosinc.com>
Date:   Tue, 12 Sep 2023 17:23:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        lihuafei1@huawei.com, Conor Dooley <conor.dooley@microchip.com>,
        liaochang1@huawei.com, lizhengyu3@huawei.com,
        Song Shuai <songshuaishuai@tinylab.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Sep 2023 17:58:17 +0800, Song Shuai wrote:
> The current riscv boot protocol requires 2MB alignment for RV64
> and 4MB alignment for RV32.
> 
> In KEXEC_FILE path, the elf_find_pbase() function should align
> the kexeced kernel entry according to the requirement, otherwise
> the kexeced kernel would silently BUG at the setup_vm().
> 
> [...]

Applied, thanks!

[1/1] riscv: kexec: Align the kexeced kernel entry
      https://git.kernel.org/palmer/c/1bfb2b618d52

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

