Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03D7E77F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 04:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjKJD06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 22:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjKJD05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 22:26:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE4744B8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 19:26:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b497c8575aso1653901b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 19:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699586815; x=1700191615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGqxz8Jd/zanbd/e+X5hQTmawezc5bW600nwJml/3VE=;
        b=Gq183UXOqYwU+VrTUZx2QO7kTtgl0J9ZOQLgtqRc+N5VbH59v31FVQvaPxb8M4oOZ1
         3tm08bccMm6MnUupJIV6wlSAg9OavNCtoGJ1egvw7uAmwSL7/Vu5vepJL2Rp7TpwOrAr
         BzAGfxdkoXVr0ZsO56Fj+cVumwOUYSZ6fp+4T8YfV3v4ssTFefRsdN1H720D19MsD/Ho
         XWEunKIfWGeHuvQanPO/dyJTHonY2WJISUkIj5XUO0Cv2Lrn4mwqVBrFEf1Mh8fGfCQh
         mK2vM6kcLqpY5mdVlTsrN2wVv5IRp+KW1BOfWEZE4lr9sZwKwiWMExwuvmL3+9aMb3+A
         7YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699586815; x=1700191615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGqxz8Jd/zanbd/e+X5hQTmawezc5bW600nwJml/3VE=;
        b=OuwWPVgeOKeFEQaFC/qvjxtg871GsnRC9LZ+Duer02nYKpj6zJErl+l/LEF/h/yBob
         wWyUCac9byF1cYBGQ38ER28hjvFcXboqrxmGlaW3kIQAlxAl/3oNHN62fWf6RdgCE5x3
         c2rkTf2e3PM1jLYfsgTm4YgoTuIJGK5Oz4NUt0UdzyWTlAB6BUelBHScj/U/UalxwEgx
         JMCw2EuJeQYVT0Y7kFCtbfhzJwgO0Pv+qionA4eV1ktz2WFZ1T6/x5BwljKN6OxRvtQ1
         YShs00WQHbUYkPF+OViUXgoTNssuuLKDJX3ttPpDRtF6B+qGeoaPElk3vMCuFu5UD8pJ
         uZsw==
X-Gm-Message-State: AOJu0YxA5aAQT9vNr/TMWl3RQf9C1/LUcwcwOoBli/ZgWPHdVWuUFlwa
        O1bLusJRHDToqM+3eI04ujg=
X-Google-Smtp-Source: AGHT+IHxpqm1RHfS/+2B2d2hW8vbZjUp8T1eU8hfkK8QRT8SVVQzoS1btARU1pAyNhXe60Uk74SgZQ==
X-Received: by 2002:a05:6a00:150f:b0:6be:5a1a:3bb8 with SMTP id q15-20020a056a00150f00b006be5a1a3bb8mr7785919pfu.28.1699586814850;
        Thu, 09 Nov 2023 19:26:54 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a00084400b006c4d2479c1asm455799pfk.219.2023.11.09.19.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 19:26:54 -0800 (PST)
Date:   Fri, 10 Nov 2023 11:26:50 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Ferry Meng <mengferry@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH v2] erofs: simplify erofs_read_inode()
Message-ID: <20231110112650.000045c5.zbestahu@gmail.com>
In-Reply-To: <20231109111822.17944-1-mengferry@linux.alibaba.com>
References: <20231109111822.17944-1-mengferry@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Nov 2023 19:18:22 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

> After commit 1c7f49a76773 ("erofs: tidy up EROFS on-disk naming"),
> there is a unique `union erofs_inode_i_u` so that we could parse
> the union directly.
> 
> Besides, it also replaces `inode->i_sb` with `sb` for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
