Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F207A0A47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbjINQGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbjINQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:58 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559B1BE1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:05:54 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-792973a659fso1650739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694707554; x=1695312354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2G/8FvmJuP7Q+IcP+fUXoKKLeBYjk4CrYgaYipCuRQ=;
        b=PNfPgDumQkQ4UmlqIouS6Kw+Vx3luxj/Gcvk6Qz7OOZZjbkoEx7ly4ntzaMqMfzk04
         S3iSNqN59eTzSn1wYspIPO35SZ23QgZl8lM7KhdVCgin5DIXQvEkoIMYaS+5hHfHSYLu
         1gDj9uo57Fif3cywrNK+m6Uzb6LtPWJ+BMMbHJeXLVdISt24GPC4qhbEW3lfyZOZW4tk
         I/K7TLE9SFgySnXjngOl3kuFDOuRtPQuHSoUMbZxK5XewjbW72xWwVStlfRkYGwfgvjs
         DEWVjFT4+x7LBT/JsaJf3dBqXZgfIRyGb6ZCevV7miK7phMXWVCD54eOsLTL+LU2LhXz
         24yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694707554; x=1695312354;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2G/8FvmJuP7Q+IcP+fUXoKKLeBYjk4CrYgaYipCuRQ=;
        b=ZLdM29biSkYUGyz9rlX/mMA6V9z5vgG8Xw2+SlmHyC7KICvHrZCRlWCb2+4Hil6DJ3
         KHFsReMd+BpEnVFeWG9PNsiOivdmYPnR8WaeFwbs0HngwcX6733MJ1PeWeG1ip+tbXTn
         yxTgMJJjHAzLOw6OG835n5NdJ4SwyqNXWVvb+KbQ2px1Ig6JcEVtSlIIoywqY9raB373
         nwntxtoRq5zPOGO4yFa1TIUqYNcyLAkLhxYrJV+GK5/PHF6J4A8OPo0EfcF89Xo1F4Gq
         SWwlCRTjPeBGDpK9lIWAOpgDwhZuKi6MY+43it5ST2YWdaOEg50vrGjsT6OOVu4cHNUA
         nbeA==
X-Gm-Message-State: AOJu0YxMhjKMLLVpToMUvPPM17NfKIU8w4kSTNTxXY/W91kvXlSwKBup
        Do170h7BL7zkk8OplKgJanWp6Erljmk+W+vVFQ3ojg==
X-Google-Smtp-Source: AGHT+IH5OxR1xf+yKXMKWvOe+xfW8ExWSTxWbzQqanpHc1KaLzdtqjI/ltyg8deWBjg03RZ+8kTjbg==
X-Received: by 2002:a92:c948:0:b0:34f:3b12:799e with SMTP id i8-20020a92c948000000b0034f3b12799emr6157784ilq.0.1694707553871;
        Thu, 14 Sep 2023 09:05:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e7-20020a926907000000b0034cd2c0afe8sm523083ilc.56.2023.09.14.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:05:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20230908005702.2183908-1-chengming.zhou@linux.dev>
References: <20230908005702.2183908-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] blk-mq: fix tags UAF when shrink nr_hw_queues
Message-Id: <169470755284.1974464.819655197479037967.b4-ty@kernel.dk>
Date:   Thu, 14 Sep 2023 10:05:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Sep 2023 08:57:02 +0800, chengming.zhou@linux.dev wrote:
> When nr_hw_queues shrink, we free the excess tags before realloc
> hw_ctxs for each queue, during that we may need to access those
> tags, like blk_mq_tag_idle(hctx) will access queue shared tags.
> 
> So slab-use-after-free caused and reported by KASAN. Fix it by
> moving the releasing of excess tags to the end.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix tags UAF when shrink nr_hw_queues
      (no commit info)

Best regards,
-- 
Jens Axboe



