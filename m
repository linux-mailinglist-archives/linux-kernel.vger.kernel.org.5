Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAD7AE62D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjIZGn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:43:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0CEE6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:43:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3233799e7b8so86533f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695710627; x=1696315427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU0wg62lr2xNjaScPCD+4bLIPZbMjKJ/swUkKHzUNCg=;
        b=sGrWUYCBiJQXmND1bAGvoN10uLNOTnG11fEoheFBpk27R0lxWcpSQNdTlIlXVuA14U
         j/L3o/m8qZpvMybFzIi9laK32dHgcJkrKALWQ2EsXorFZi9fh6Ky57J18JTY3saEk2Pu
         Btn/+vtGoGc3mz8/wdghRydCI5VJ1F35fZjz7czh0ktRxrOYkiQj+vzX9xRriUtLChLU
         CwFU7z4zoiIH7Qp4a1UKKCXo1GKTVYzKX72lfLkuUTre2YFro9MjcxggtOzajsoaxElH
         6Nr5/vcno6qXT/WXHJZRtzWcKozd+Yk/9wnwsfRjVfHC+CeWv8gRs4UjID3sUIEMP+0t
         tofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695710627; x=1696315427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU0wg62lr2xNjaScPCD+4bLIPZbMjKJ/swUkKHzUNCg=;
        b=Rzooo3t3qvNxIuRdHtBsVje7jnqnontr6AY6oLd7OGwxzJ/WeNI0BwT0VP7JPkuSc5
         zouyT2HpWmU7awYtDIcvHDFUMvAJWv+k+V1OrYZNE/8XpOFwD7mrWN8ZvUF00BofsQb9
         0hfwdJPo3VhC0JXrD80LJYj7T5nfMQuYq1ZxJqLe5HiliWTJY+HoY9NgdySvhXo6KYv1
         TmX06tYar7wXTB1Nl0zoRQC+UCQFg6s2KAFagwEmjdlhqr4BQwy8PNltkhbyPLjPxu51
         NavLa0RfZyZrzCPzwb4+6n5swv0o5f/V7lH8nB0TJcWH4FyrRILJPW1K5zcQtLVpD/B9
         GJCw==
X-Gm-Message-State: AOJu0YwU9WjrWGNy5G3NMDtkZ7gPUbncg1YCCyR6H6DDCVoWqgyUerWg
        ATvhabW87evNGUAafnsn5BTUlomSLgX0z0NSIiHh5DB0
X-Google-Smtp-Source: AGHT+IGDVncgjlr1M8g8f5L3NQijHmN4vBIf89YmGQkfQudDtKc3xid0isSrBgZT9hJ0XdBtdMlXPA==
X-Received: by 2002:adf:fc89:0:b0:317:7238:336a with SMTP id g9-20020adffc89000000b003177238336amr6910141wrr.5.1695710627495;
        Mon, 25 Sep 2023 23:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b0032167e49619sm13758109wrw.5.2023.09.25.23.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:43:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20230926005232.23666-1-rdunlap@infradead.org>
References: <20230926005232.23666-1-rdunlap@infradead.org>
Subject: Re: [PATCH] block: fix kernel-doc for disk_force_media_change()
Message-Id: <169571062634.577707.15764939880513654865.b4-ty@kernel.dk>
Date:   Tue, 26 Sep 2023 00:43:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 17:52:32 -0700, Randy Dunlap wrote:
> Drop one function parameter's kernel-doc comment since the parameter
> was removed. This prevents a kernel-doc warning:
> 
> block/disk-events.c:300: warning: Excess function parameter 'events' description in 'disk_force_media_change'
> 
> 

Applied, thanks!

[1/1] block: fix kernel-doc for disk_force_media_change()
      commit: a578a25339aca38e23bb5af6e3fc6c2c51f0215c

Best regards,
-- 
Jens Axboe



