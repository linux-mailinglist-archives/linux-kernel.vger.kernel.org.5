Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146567A2751
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbjIOTni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjIOTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:43:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2011FCC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:43:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-577fb90bbebso1747336a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806985; x=1695411785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYJud1t9lPyuPjtdwBUAsD3BvXWOOoP+siQ8uzoHdDU=;
        b=lv1AMfeEfiHIn4vWjkJMk6a+yMVmMhhtfeZJjM3put5fvaifKq7g2lhVGwER0Daw93
         ynoj6O+ATUqllHBeZro2u7NTsIzpaJVLN41BpjOzxK86MFYu8nPdhlfnc4Wpprd8egsv
         I1F+LPgHMza92k1ilz+o8T0LlusPuOj0FSAFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806985; x=1695411785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYJud1t9lPyuPjtdwBUAsD3BvXWOOoP+siQ8uzoHdDU=;
        b=SgJzYm4YEOMIU8938ZDn3yMLB3W392Ctln1F9NW1SJSAmqdtPuGtDNfTeOtYWUCaj5
         NdEXgM2AZ4THl4tnqObY2kq9k7sTmygumAfECsxs3dgBLsoZg034jhN8smtTfMyw1Ose
         be8oelQrKu1zAq9n+KcMeVdbemF908sSarGktbDV8JCodbDimwZUyP6avP3WlG4WXQsR
         L8jwSwiSfeeDwzThF/K5/nQPA+COfsNHM4xTa61Ws++SmbgNXJQCrAyDDIUIEOs1IfFZ
         9ProvybyfEPzX3MhThaVDdDE5GVgGIGHezOqXqKAIYQyVmPsd6q/aDO2Xj43Dwuv7C2s
         lNMg==
X-Gm-Message-State: AOJu0Ywu0Ay0Y0j8bTl4uuDilatM2Y3Y9hW+03NxEKaHHbedfvN/xlrq
        zXjqDcGvf2EGNTmpi8Kii59YbQ==
X-Google-Smtp-Source: AGHT+IFeG9K8dCFdWE7JO8su8gomrvm80dps740wxaqk3Qc6GiQQ8BQQx0l1yX49avLzT86ttQjnhw==
X-Received: by 2002:a17:90b:38ce:b0:274:96a:5007 with SMTP id nn14-20020a17090b38ce00b00274096a5007mr2503313pjb.1.1694806985660;
        Fri, 15 Sep 2023 12:43:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ft7-20020a17090b0f8700b0026309d57724sm5200947pjb.39.2023.09.15.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:43:05 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:43:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tipc: Use size_add() in calls to struct_size()
Message-ID: <202309151243.647E424@keescook>
References: <ZQStiorAZPgfMMZD@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQStiorAZPgfMMZD@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:16:26PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: e034c6d23bc4 ("tipc: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
