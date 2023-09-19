Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778237A62FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjISMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjISMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:31:32 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF708F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:31:26 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c46430606bso340148a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695126686; x=1695731486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mzxRe4ddIChTt1Pkh7gP6Z3M3cc1YUTNoEMJ6jpC8lg=;
        b=TsdIn6snEH++U82oM/8TLSD/gWhjz2HZNxv70511TtQ3uyujLNLtVFuxA1jdiymyOW
         a4EXWBVNuhh5QKVkARaEJM43i8IzETq0gtTvYewqyJ1crn4/goWPn7YK/8cDXa9rXFRV
         NJd46lCTMhbu8HvylzNBb9rPnNVK0bWUbQRRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126686; x=1695731486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzxRe4ddIChTt1Pkh7gP6Z3M3cc1YUTNoEMJ6jpC8lg=;
        b=lYP+aNOMlqGlMt/WRlFV4ZYSSEcysvavGYvGJqhmglI1eQYdP6qpkSqIk3Ahfu62RC
         hyWbxWXq8A1R6NhvkEpFAxCQ6+CZJgEySq151N3SlQOwA0OCfuY5kIk17J8yxrLNxHOL
         4qFQqmnU4Bz4rmAe16ezyNLH3VW/899OJOVWNqKJu13XjR4JRko1qU/x0J1nxFLltf1t
         +j+Tlqj1uHAf8ly5GADXHT3hMKqmAf6wg7psRzaIsJl4t7e+ajgbduNC9bXAMcmEr5YX
         qkGE63Hn6vxg3uMRwsaw38szK89To7OoG/6JdiRW857IfJGvegJXMOEM9xi1qBhaXcBG
         dnLA==
X-Gm-Message-State: AOJu0YzcwP3UvNScJEKqNyXHbsnZPI4py5tm+J/fnZilkZQpXFYi2Ggr
        xqb0Vv+m2AJmtedoO2cQBgJVTxTXtWatFbqSKGbvsA==
X-Google-Smtp-Source: AGHT+IFhzR4yaizcV2SGxVqQtHNxts0kTOB0pDEuZXWa0DdZF1YoACVbLs29DNJ3sO0u1g7k5QY55ONDq5ZG+qDDdrQ=
X-Received: by 2002:a9d:69d7:0:b0:6be:fdab:dc59 with SMTP id
 v23-20020a9d69d7000000b006befdabdc59mr10806957oto.20.1695126686121; Tue, 19
 Sep 2023 05:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230908104308.1546501-1-treapking@chromium.org> <169504317624.617522.1000616001928521648.kvalo@kernel.org>
In-Reply-To: <169504317624.617522.1000616001928521648.kvalo@kernel.org>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Tue, 19 Sep 2023 14:31:15 +0200
Message-ID: <CABRiz0o9a54+Vq=MKCxu3kXQyKw8jEPjixz14AU6jkY6tcmAig@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, my mistake, I was unaware.
