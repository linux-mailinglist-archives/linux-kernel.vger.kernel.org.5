Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD47B4230
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjI3Qel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbjI3Qej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:34:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110C0D3;
        Sat, 30 Sep 2023 09:34:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c61bde0b4bso94150385ad.3;
        Sat, 30 Sep 2023 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091677; x=1696696477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ewlMK21MKF6oJNKsgHRX5GI6if3+DmnKGcJn9diq3M=;
        b=dRnidEflpLHnPYPtw7r8l9OFETDqz1nJ1JnUw8S7sFmo5/j7zw9BXbjiL8HqJ9IuNJ
         9DKFPjObTZdv6KcNaAQ2JgUt0YPk0OdTVi2ySJnjxVs3ZddOVqLSfLFmGiQNGHS+YjZH
         k9KwpFZoLeN+Bz6iiaWQtODvtfa3bXxvqIUYVRsJy/oCOloLOVRc79vsYPQeOmfVgPOp
         Pif0Wymm+XeupKasTiz1RsFHdqxIdXtsQEU8BuA9fP5mOnTbYa6oPuiCWnNPMy6W2lLr
         ztDLUYNf2BYjNvvV66Gwm7y5WbMO7BwBW1/3Pfl3NE7tLywL0VyLefxxBXE+WPD7FvdJ
         Hrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091677; x=1696696477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ewlMK21MKF6oJNKsgHRX5GI6if3+DmnKGcJn9diq3M=;
        b=GCFl1tTV++i0CogiSoQ62i65KjCgPXhq4CNeUsvdSVvh00jEhaFIHIxnSlDrO6dw4K
         a0YsZ+fHYi7uFUTld/TH8KHKjaXnOSb8QYYDzDTAZTjTgmDJQNnb3k7FlodlqpC6byUp
         kO7B23Jhvhu7yuojfOpykFU1kXX5Gd4h3GDeHeLwFc2ZwzLScl5LW8FazhG6zDSrugYm
         oVCqwWQ/SSzoJwzket4jl6vZki0xVXkTXi7wqK5lP3yLzZMgkPCUyxlvnsoITLLOeBQT
         ycgKkYHHoLT10qrxcvUyMjDyPTqU390KOPz3JFyt2LuPggVmGn6d7eIC3zK8+ikA5AML
         oUyw==
X-Gm-Message-State: AOJu0YyEGGHOHnOszQZW0M2Aq5vy0KkM55LEXxQ72ucvLlxMWawX++oT
        UtrKvK9LMn/BLKzp9P0SHBM=
X-Google-Smtp-Source: AGHT+IG7lbKTIdQ5hyO75ovbO8AXTNMHRGFsh8NoO0PZ08axK5wOB9G7iErT7i10qxrbCPjqMezcIg==
X-Received: by 2002:a17:903:11d2:b0:1c7:2697:ec0a with SMTP id q18-20020a17090311d200b001c72697ec0amr8541234plh.30.1696091677410;
        Sat, 30 Sep 2023 09:34:37 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a90f:2dad:30c1:d923])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b9e86e05b7sm18923187pld.0.2023.09.30.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:34:37 -0700 (PDT)
Date:   Sat, 30 Sep 2023 09:34:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] Input: axp20x-pek - avoid needless newline removal
Message-ID: <ZRhOGiZjEI8EEgtl@google.com>
References: <20230925-strncpy-drivers-input-misc-axp20x-pek-c-v2-1-ff7abe8498d6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-strncpy-drivers-input-misc-axp20x-pek-c-v2-1-ff7abe8498d6@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:31:05AM +0000, Justin Stitt wrote:
> This code is doing more work than it needs to.
> 
> Before handing off `val_str` to `kstrtouint()` we are eagerly removing
> any trailing newline which requires copying `buf`, validating it's
> length and checking/replacing any potential newlines.
> 
> kstrtouint() handles this implicitly:
> kstrtouint ->
>   kstrotoull -> (documentation)
> |   /**
> |    * kstrtoull - convert a string to an unsigned long long
> |    * @s: The start of the string. The string must be null-terminated, and may also
> |    *  include a single newline before its terminating null. The first character
> |    ...
> 
> Let's remove the redundant functionality and let kstrtouint handle it.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Applied, thank you.

-- 
Dmitry
