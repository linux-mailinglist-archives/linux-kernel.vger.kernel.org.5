Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8587CF4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbjJSKJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbjJSKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:09:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D518D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:09:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so341798f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697710172; x=1698314972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkUOzd+vqXC9Gk9LtENIqmvEDih8D3cQD5X39rjRw90=;
        b=J6xFZ6pLgEkgt2Py5t0CnQRnASsBWoALpqk+aE+UlkGfzIZk+wLyJKC5B/1+8yTgw1
         OdSlqFiLs8ZYndaeN7JA01pYWmlExh2tLZOW9O6fBhHhYGuodVpq/3oRCg/NELq0P9UV
         NpBGAieXNXhGxUmXHC6mbq1XHnqn4QsSMrs7cjf1JyjDoeh9wbKhF5AQv4nIA+YXUC+o
         4Q61fltjA0J9aIl9FWIEB/hFqQH2h4KIhnmPyJebK0jgOIp9lNgQTZSbndRbfgQ+0bJQ
         e8SD+y0qbl0kya/s6nR4kr7oc5btjUzZsyuuunMf3NXaHJ8+wTBPl6xtVAZndRNl07/2
         j8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710172; x=1698314972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkUOzd+vqXC9Gk9LtENIqmvEDih8D3cQD5X39rjRw90=;
        b=b3o0H2KiFZ51Xtvxa7h7tUA4AkaJQHIk1tN/Tpg1T+RkhrbN/vCdCyY6oaiiluBw7+
         E0ucxcjCLS3mUPiBzCFUU2niwRTpydBa5V0TFLO19QumlahLX/WSJHW4lgVw2YNZKCqo
         3EiKciRBQtdQBpahGvBiUwQsppKvzH7ToYOo+Lf+3cxbivhn5gy7MjyeT6sSbrpa+8Lu
         HyZvGXFpBic7qLvc8r2zU30IBtUY9a2FxRpAuNcTSVRELQBOW651pIITUCUTljGfxTM8
         3XpU+hSv+8FdmH3vaWioFYtkGrs9hAbxs+jthPazU/qTmE/PuvlbRCNNZGvU8bRpX9w7
         5doQ==
X-Gm-Message-State: AOJu0YwFsSkdXKA8HnjbcKstIu2QBe3X04s1qHaC3EbCYHIjPd4MLdvQ
        yMOJdGORKsdzFD8Iwdu/9SIhig==
X-Google-Smtp-Source: AGHT+IFl7jktVX1hBG6LQ8h+AJkNLRQtADGCzsqQdX2oIM5MlIP0CAGDx4nFhmRz3exViow5B+YusQ==
X-Received: by 2002:adf:f80a:0:b0:32d:888d:7598 with SMTP id s10-20020adff80a000000b0032d888d7598mr1448946wrp.4.1697710171905;
        Thu, 19 Oct 2023 03:09:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n13-20020adffe0d000000b0031ad2f9269dsm4098708wrr.40.2023.10.19.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:09:31 -0700 (PDT)
Date:   Thu, 19 Oct 2023 13:09:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: snici: Remove dead code in
 snic_dr_clean_pending_req
Message-ID: <15081b01-2915-42a4-bcda-0d8243741baa@kadam.mountain>
References: <20231019083026.1525366-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019083026.1525366-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:30:27PM +0800, Su Hui wrote:
> Value stored to 'ret' is never read, remove it to save space.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Could you do this a bit more thouroughly and remove all the
"ret = FAILED;" and "ret = 0;" assignments.  Just "return FAILED;"
and "return 0;" directly.

regards,
dan carpenter

