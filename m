Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C017E9240
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjKLTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:30:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14E1BFF;
        Sun, 12 Nov 2023 11:30:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc921a4632so33275985ad.1;
        Sun, 12 Nov 2023 11:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699817429; x=1700422229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJm6Mh4+ZHA7/pgm2J2SRO41c+3M2W1YQNabxlej2Ko=;
        b=XnHLfiXFjLr0Oyrugdw69RUbMsjX8SNEFX+2hOFAFemmEfiTGKEfTv8nYFivLoFVYZ
         fLE1G5izjT++P1Q/VcTLEYlT2tDOCQ9N5afeiHf17BKbgOsT/CKrGNy4YeokUO0/LBz7
         2WWdvFAgJOcQMUc7Hs3A9BRY8Pacjd1xmT/q5qyGQP1+PRDwQWnvrsB9CIdB4h+kWHCr
         TFWyki2rn23PFLggIMP3M8xzEcRkAg+psdPvskn9ltNkumysBMK6EB0SgYd81efLoMsU
         0KQuJtZaAqNxXJ562S8wL3hMMdDT+M7otl9p8czzAXSGULcgEXe+QH4pTRb2X0AMAtVM
         Hg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699817429; x=1700422229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJm6Mh4+ZHA7/pgm2J2SRO41c+3M2W1YQNabxlej2Ko=;
        b=ellQC/FtgTOiCgdJFNeoSpegkKASDhO/WnrPGUJqrrow//6jDPqEys0O4N2BPWJQ83
         dkrTHID7M7tu8iZi+MwoegkZeetqkrjd6/c1SGWObt2cyrjUEb40Kx1Qcb9HSRrxwy7y
         6OCgjYaK8gZ4IClXJX6mLmCNy0YmFe7q8uVSvAw4Y8kQIsYspZPRJj5IJUBcfqoWiGFy
         grg8fWoVvokFTv/Kv2LVmMNpo0IKwXjdSF1kYytqLyClXbKxIP/SuTba+3iw+90LvK6k
         LgLEsZL7pPxlvS7ebboq2PiOmolTmSHjPx3F993RuJNEhLYVqQ4L4Szeu/Z0GmUUWSXn
         5N3w==
X-Gm-Message-State: AOJu0YzOYpdOEt68c0IKCNQE82iqkxiZV4+LXeVdctAGx9v9CLUlGqYU
        b8jpHu9QKl/rFIAg7Ey2KUM=
X-Google-Smtp-Source: AGHT+IGjlf4GCjYiCAytAvSrC1xIIYHFIic7/6VL+I+htAAQYcyctxIGn72mNbr/sfvOBKlfr3Wlzw==
X-Received: by 2002:a17:902:e80d:b0:1cc:4cf7:2cd with SMTP id u13-20020a170902e80d00b001cc4cf702cdmr6634578plg.33.1699817428590;
        Sun, 12 Nov 2023 11:30:28 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id z2-20020a170903018200b001b9e86e05b7sm2879745plg.0.2023.11.12.11.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 11:30:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Nov 2023 09:30:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftests: cgroup: Fixes a typo in a comment
Message-ID: <ZVEn0jcGeFOQKhNW@slm.duckdns.org>
References: <20231106181034.117120-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106181034.117120-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:40:34PM +0530, Atul Kumar Pant wrote:
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun
