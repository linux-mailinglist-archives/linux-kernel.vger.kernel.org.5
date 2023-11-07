Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74C7E3518
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjKGGNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGGNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:13:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79170119;
        Mon,  6 Nov 2023 22:13:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c343921866so792349b3a.0;
        Mon, 06 Nov 2023 22:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699337610; x=1699942410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp7jbiihYbJYm0zzWTzb+AIe0679YmZMzyU1A+ycvSI=;
        b=QQadve3r6mE9ARcVpgO1YwH8yQCycCkEtLSsjXyFf4M7QV8JubnAIxbu3myWMinL9E
         5UjkcsMyATqDgAFLW7kgvylKWveTv4FxoBlpC/+V/RzsEb5oq6EtXJBLTO+B0OaOQmzy
         yCRo4G0QnLxzhDBP6nhf/fj3jZDzwn+V911d/P1mqdzwLNnT6GNsdM3r2L9NbzIlFeKl
         NeryydE0drGYchglywTKJV2fxZ9C4CfSmo2US5SYjfyVpGLzkcfE0nOkYkKWoqo10IbP
         bA1nmwSMQ8kJsLgcvnxOEm1axmJLv3SdQ6RcDKXZfDw0k3cX2MUfVFq3BbJFjLlaezsu
         fdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337610; x=1699942410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp7jbiihYbJYm0zzWTzb+AIe0679YmZMzyU1A+ycvSI=;
        b=KcctOlfghmL43kgpB8A5dqVhwcLUgNk63MsHCvvb2jLTmlFwYSUT9lBxzEfE/VdRhh
         z4sLSxqGSNh9ElwYSWKdOtr8Q0cIxF2s4wK/hAx0hD7qmdQGYxczupyuGR8JGHegFRub
         hvUuUfQOHb718GJqUbgf86v+AgPoMoYONDuJSpZGK34yBRS72Nvk21v4lQeF1mbxNql4
         A1KgL5tTw4LJv+u5AeD3yaw6llyv7mAPqgCx/GvwGDvPQCm/RhCoNGfOapoOhzyUC8L3
         89Wq5gjICsEUp0baKYz+WdXOrxi/Eg3oDfARJWNzCYzguX1x9uQI3uhTRzXVbZekxzuu
         R3Wg==
X-Gm-Message-State: AOJu0YzbHY58TzwS+M2GCklHxox8ygbDf5VOEiI9/iZ7l12sVebW97nc
        6zgLU5Wc5nQbly8EIzN5ueM=
X-Google-Smtp-Source: AGHT+IHJ/zV7B/Knw714zPDTcGbgSSiBPrlmkDERaU69DQfdwqHRcNkkQLHXZpmLDrcX3vrWpmJpJw==
X-Received: by 2002:a05:6a00:4a81:b0:6bc:ff89:a2fc with SMTP id dr1-20020a056a004a8100b006bcff89a2fcmr29866425pfb.2.1699337609931;
        Mon, 06 Nov 2023 22:13:29 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006933f504111sm6692681pfb.145.2023.11.06.22.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 22:13:29 -0800 (PST)
Date:   Mon, 6 Nov 2023 22:13:27 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V8 2/2] ptp: fix corrupted list in ptp_open
Message-ID: <ZUnVhxktZCpFYwEg@hoboy.vegasvil.org>
References: <20231106143127.3936908-3-eadavis@qq.com>
 <tencent_1372C3B5244E7768777606C0F36563612905@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1372C3B5244E7768777606C0F36563612905@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:31:28PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open() and
> ptp_release(), which can cause data corruption, use spin lock to avoid this
> issue.
> 
> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
> and it should be deleted altogether.
> 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

(This should go to net and not net-next.)

Acked-by: Richard Cochran <richardcochran@gmail.com>
