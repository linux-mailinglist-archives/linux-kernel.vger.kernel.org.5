Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42A87B11AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjI1EpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1EpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:45:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49220121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:45:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40652e5718cso390135e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695876314; x=1696481114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AcXbSw9sTgnfH+W7z4t4vq2SV8G0kIJTK37nKEDOZg8=;
        b=Fk9A+J/iNTcG5mmZaxn119zdBOQLgH3bJiCSG58CoPQ6hmHplkqESLxZ6Vdvsz8IT+
         3tpJFpvMrXOQMQ/p9IWLNGJEmvhwCSzUiN309inHaj4FQEAnIhelMCeAju7v22IQdLnj
         92fqaNgLqii/rNOEOv+wxPSyOMUUHN7PkCmG8+sQHPKqC72SEWk9ojW3Wb+JJbXREeSQ
         CCDmPg9xenS3xd+sXGNtnCud+YfdskJTd2R7QcDNPn7+xtUNF8VVHKtMTAmNYzcflv2W
         yKCpdoEughQXDB/OVrFDKBe0suD+ZGw/etpSEqjHAgcNBKkJIqCb04xi+CBumWr8Leyh
         p9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876314; x=1696481114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcXbSw9sTgnfH+W7z4t4vq2SV8G0kIJTK37nKEDOZg8=;
        b=ctaYGuEzfShUvqqNVWoF3uEUR3sXAazFbOXwewL5TtODesiMCZgr0J1aVJVDQzVzpL
         iVXVmiCpjMcSDCLwx/JBVSRKfhcnpmQsgZBw6o18HCO78bRYDKg8gZqVcoS9a2d6zuGx
         4GZrmiyfACBUSrs8txTmjSjKLeRhf6wN+rF9wvcS36cEOieCpBWsF51zmgkQIWV9WaLi
         E4nqRWkP/qON9oyowOlqO07inxndbwzr7S8hBDxkS8VbuwWZS0eJ0dm0OcJRAKdBTa36
         +MWZVa6YlfaJRgZnPnk7G3hbwk7KIEAiVg8JNMQdZYOekjqMhwYZx0xMvC1Z2tTdIk2B
         6nsQ==
X-Gm-Message-State: AOJu0YxYN+rr0gmmkDyIydSWmuW4ZcY2QUWA5S/QKJxowzULoOTDTmcO
        uJooork8I0p9nCr+HauymFLlMbCockKMhwamwTk=
X-Google-Smtp-Source: AGHT+IEj2dreycHkxBbNtsaNblGI5+CWZlWjlbetRiCdKoxnqgfqJnEdezRsuB/1ahQnef8LORtuww==
X-Received: by 2002:a05:600c:3b22:b0:406:5301:4320 with SMTP id m34-20020a05600c3b2200b0040653014320mr81206wms.16.1695876313748;
        Wed, 27 Sep 2023 21:45:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040535648639sm18988603wmn.36.2023.09.27.21.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 21:45:13 -0700 (PDT)
Date:   Thu, 28 Sep 2023 07:45:11 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ovl: avoid possible NULL dereference
Message-ID: <91ae5901-fae3-42b8-8c82-dc5c2683b4ce@kadam.mountain>
References: <f929f35e-2599-48e4-a77f-f2002bc94482@kadam.mountain>
 <b1a6134d-f976-ed9d-aac0-06f3c93fc1c6@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a6134d-f976-ed9d-aac0-06f3c93fc1c6@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 09:12:01AM +0800, Su Hui wrote:
> Got it, I'm so careless that make this wrong patch.

Not at all.  Your patch didn't break anything and this stuff is subtle.
I've done the same thing myself.

regards,
dan carpenter
