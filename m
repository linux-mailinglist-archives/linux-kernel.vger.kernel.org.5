Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50657DDB01
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbjKACau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjKACar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:30:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3BFBD;
        Tue, 31 Oct 2023 19:30:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1cc13149621so11834965ad.1;
        Tue, 31 Oct 2023 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698805845; x=1699410645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJx1gCCJdYe6w1k0ztbhtZDsqbmsvBkB8hSiGVC++eQ=;
        b=BQ2XJZAXQFn5HrJLnlG6w6f04L8jPKx3/jXVxtoN4qQS9vNJ166Ou0HZ+DrGkoLZYn
         hFfydrYQr8sw2qAgbyx53IahM25DDwlAezzyycYZMz6Ml9VvnrHorwffpDk5jxwRgY35
         blc4nL3RbcbFRFviexKVzedSnXX98HTYvfl/YsGcasDmfr5G43jqyzAIeXkXLk0QZ4xO
         TpFJhe6StTAk3NI8DLETLJQXLMQdMiUIpVvE7Xuu3OpZXK3h1tnUoIvpKjqBGa+pvswy
         /2ZRmiU/+++cixdPpd4A+EdubuZPQE+6oI9Z0h3ggE/ppXo5F+w6R4yjbNC5hOh5lBmf
         JJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698805845; x=1699410645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJx1gCCJdYe6w1k0ztbhtZDsqbmsvBkB8hSiGVC++eQ=;
        b=Sd2Je+IqqjEZiTrl8HxTreYBO8+mbl0vBQ0IQibzSGaADY3Y39o7aJ37lBzizEFRUC
         jyrpK0HEDdJZc7eePSYUEsBVMwW9dqdhMNJ1abRbXhHY0VFuwlAfnN09e679D1iztk62
         XkPY+AaIzwpsIYG0NLFmuvp3DUr6ziQjWgcnYEeDEodzNcBRo/RU4felIZqrSf0ptVdL
         LcrUnNRHbWTpx3AiWFiAr6g77ECY+rv6KDe0wBbZNvrKfYS56ZaoV1Uk52Z2M9/bjtl5
         OMNb0K8p7aXQyaxpBoczkYz7FXRMZrhlb80i7HnM8uhG6G4M1rbeCdceEPEOdJPz85RC
         G6HA==
X-Gm-Message-State: AOJu0YyIi22FKUWPy2x0Y6JGfcd6iZ6R/vgr1YZy2TBTXfvhoDvdKzZp
        K5Gl+8SGsYq2JrR3wbmX9dk=
X-Google-Smtp-Source: AGHT+IF6VbUmw7ib/mBsZAQ0gg4BzyuZrjaSSFR7jiz1xHe2BNnC93S25te2VsButXn2Ux3Y49d34g==
X-Received: by 2002:a17:902:d1c2:b0:1cc:277f:b4f6 with SMTP id g2-20020a170902d1c200b001cc277fb4f6mr12342647plb.6.1698805845113;
        Tue, 31 Oct 2023 19:30:45 -0700 (PDT)
Received: from [127.0.0.1] (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001ca4c7bee0csm219700plc.232.2023.10.31.19.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 19:30:44 -0700 (PDT)
Message-ID: <1aec4977-05dd-49dd-ae59-f3fce8db70b7@gmail.com>
Date:   Wed, 1 Nov 2023 10:30:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ti: fix possible memory leak in
 _ti_omap4_clkctrl_setup()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kristo@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tony@atomide.com, claudiu.beznea@microchip.com, robh@kernel.org,
        dario.binacchi@amarulasolutions.com, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231031103010.23792-1-hbh25y@gmail.com>
 <ZUDZ_tDvM7oUBfkq@smile.fi.intel.com>
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <ZUDZ_tDvM7oUBfkq@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 18:42, Andy Shevchenko wrote:
> On Tue, Oct 31, 2023 at 06:30:10PM +0800, Hangyu Hua wrote:
>> kstrndup() and kstrdup_and_replace() in clkctrl_get_name() can perform
>> dynamic memory allocation. So clkctrl_name needs to be freed when
>> provider->clkdm_name is NULL.
> 
>> Fixes: bd46cd0b802d ("clk: ti: clkctrl: check return value of kasprintf()")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>
>> 	 v2 and v3: fix commit info.
> 
> I believe I gave you my Rb tag. It's your responsibility to care it on if you
> send a new version. Otherwise, please tell what makes you think that tag should
> not be here?

Do you mean "Reviewed-by"? I checked the previous emails and 
"lore.kernel.org" and didn’t find this tag in any related emails. I am 
not sure what happened. Can you please resend it?

Thanks,
Hangyu
>  
