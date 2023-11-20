Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392727F1860
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjKTQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjKTQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:18:16 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD2A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:18:12 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35b0857ce84so890975ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700497092; x=1701101892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x/sugBcPo/wJPwRXmBQQN8tg2dGBuoc9WNETNOCDJo=;
        b=z4tF8z2g8QHCiMjTEoDfV11UUORHrc/GwOUPsHLsRQlTWEghJLfIUSaV7JdEicnsSN
         X7phuhbyp8iuWf1bcFGSc1OIX/HGlVgpDy3cGRg0dYyr2lPHnUf9gei2ve8bRFtrdJpQ
         t+FncKXtStiE2E2fjVQ8ZfV4afd22vNS51IvuaCidy9a0nVIsyVDVJkXb4FrdcN+4NAx
         jVpsCSziK8jKgYneBo0LxRpybBuTPcRG+ip213EUqKeratmTQC/z8tZ6c9SLrWpc9v8F
         +efKbcsFOylkxvVoUjXGV9z/JG0xBT5H/eWgLeZgQTp6Fx+f1znOaTeliLO7WCRKOOIM
         JlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497092; x=1701101892;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x/sugBcPo/wJPwRXmBQQN8tg2dGBuoc9WNETNOCDJo=;
        b=qLlMaYJrBIr8/IXqRUIsB5w2htOYxmcd1C7giuQ2hZHrsT2cW/Vte9PZH7UcPgwgN6
         zOlKwcYswIdwIA3o44Cw5rm84AcCh7lUAUdgbT+hiND4tiFRYwLarCLtV4oNrJj8B/Ag
         aIKej2HgzGcKO47zV8mybQG+XYCXSQqaBSmBXliw3hJZ4OKM5XH8gXE3wUJQr9lOfoRe
         t+Yt5X4VKJE0OL4qlRyHXXO4v/nH8CMPySIkSkjW+74bdgsa0wMM6F3Tv7ys9Y9FK71g
         LOndK/+zdJZ2YYtPud6Q5ns5RtaapOADM+Qfspr1wZFnf865nQnfVnPi9MMBrKX71XTo
         rHJw==
X-Gm-Message-State: AOJu0YxQ2A/DlaNkzrHIhB6fYBMEaTh25TNWivc5tpv8lsjCOyZdpsEv
        oA38IzqkXMpmwTXsyUx4lh+7LA==
X-Google-Smtp-Source: AGHT+IHwfXliLfgkcDJcwMVjVN2qSgqAYam3YW3uzigd3xcp/putwJdxZNh1DNA0ZiMc/53RNKe66A==
X-Received: by 2002:a92:dd08:0:b0:359:d256:d970 with SMTP id n8-20020a92dd08000000b00359d256d970mr8026039ilm.3.1700497091839;
        Mon, 20 Nov 2023 08:18:11 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w13-20020a92ad0d000000b0035af9da22b1sm1521725ilh.43.2023.11.20.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:18:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org,
        Charles Mirabile <cmirabil@redhat.com>
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20231120105545.1209530-1-cmirabil@redhat.com>
References: <20231120105545.1209530-1-cmirabil@redhat.com>
Subject: Re: [PATCH] io_uring/fs: consider link->flags when getting path
 for LINKAT
Message-Id: <170049709091.66373.13574561690128367398.b4-ty@kernel.dk>
Date:   Mon, 20 Nov 2023 09:18:10 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Nov 2023 05:55:45 -0500, Charles Mirabile wrote:
> In order for `AT_EMPTY_PATH` to work as expected, the fact
> that the user wants that behavior needs to make it to `getname_flags`
> or it will return ENOENT.
> 
> 

Applied, thanks!

[1/1] io_uring/fs: consider link->flags when getting path for LINKAT
      (no commit info)

Best regards,
-- 
Jens Axboe



