Return-Path: <linux-kernel+bounces-16907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056E8245D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50341F22B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1A24B4B;
	Thu,  4 Jan 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rf5OGYTe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CF24B2B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67f9f6ca479so2958886d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1704384513; x=1704989313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWoFUFj8y9tncvSzwG/Qj6RhTu2GZ8uSYsNg8VQb2Kc=;
        b=rf5OGYTeSJdNW6OobyVZj4/pPDGU4TL09L1eyQhWb9dyYQRkPa4sAnZ7G2a4SQehNn
         h9AfDpu5+sms0OnAojgJk0pOurYKi/ROGLYzDwwVOcZrsyYkD+1CqB9kCwE8EgNcvY/r
         uiQaPv0yyXUHY12Bbuvg6YKx8+d6jWFo78bmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384513; x=1704989313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWoFUFj8y9tncvSzwG/Qj6RhTu2GZ8uSYsNg8VQb2Kc=;
        b=uSo88MgwewgHPQi1P3C72Y6hhI7TqbXcX+r0JP8zpOYWcUJtCebd9Bq8xlomA0I+Ak
         zmZ4DQWllvHTf7IfrurLQO5EeMVruzCphL+I2tov+B7Lg/nTHw7woA78Ps9UmHxcUUUg
         0gsniya+8m0FMToxlW9guETgWC7kopitdacQxTPQdGZicj4dRwJGn8pnLo28UhLtle5O
         zPSeOENUPlm/hJFGumQoNF9iXbEoXjkmi2+Jixl/zllhm34/CVCQ+9qfPpk35rSuQQAq
         bL1mPvWQ5njLLfy3FNZWInDUwZmzbB6OgXQXUNOE6rFdAYEBHvKV8Ev87fU/mvaEF8QX
         PsXQ==
X-Gm-Message-State: AOJu0Yz8yZM+U8c8Z9y9ST1pk44ibWrvsa9pFKi47hydjw0RkIc3fy3O
	1Kc4GZzbg0VCW0fx3LwLt54kMSb3y5qEeg==
X-Google-Smtp-Source: AGHT+IF7TDITJaTznAYjrrd+kY46g73rnPRz6RfIDo4M5gNoM5TQ/GTUCIrOTwJ++uYKSz9XpVBL9Q==
X-Received: by 2002:a05:6214:2625:b0:680:d4c2:a5d1 with SMTP id gv5-20020a056214262500b00680d4c2a5d1mr848733qvb.66.1704384513274;
        Thu, 04 Jan 2024 08:08:33 -0800 (PST)
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id a15-20020a0cefcf000000b0067f812c4a58sm11592869qvt.60.2024.01.04.08.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:08:32 -0800 (PST)
Message-ID: <4655f620-e43f-4381-b3d4-c8d5555fd739@joelfernandes.org>
Date: Thu, 4 Jan 2024 11:08:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] android: removed asm-generic/errno-base.h
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Tanzir Hasan <tanzirh@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <20231226-binderfs-v1-1-66829e92b523@google.com>
 <eacd168f-22dd-4e11-8907-0c79ee33f595@wanadoo.fr>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <eacd168f-22dd-4e11-8907-0c79ee33f595@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/4/2024 10:36 AM, Christophe JAILLET wrote:
> Le 26/12/2023 à 18:09, Tanzir Hasan a écrit :
>> asm-generic/errno-base.h can be replaced by linux/errno.h and the file
>> will still build correctly. It is an asm-generic file which should be
>> avoided if possible.
>>
>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
>> ---
>>   drivers/android/binderfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
>> index 1224ab7aa070..d04ff6029480 100644
>> --- a/drivers/android/binderfs.c
>> +++ b/drivers/android/binderfs.c
>> @@ -29,7 +29,7 @@
>>   #include <linux/uaccess.h>
>>   #include <linux/user_namespace.h>
>>   #include <linux/xarray.h>
>> -#include <uapi/asm-generic/errno-base.h>
>> +#include <linux/errno.h>
> 
> linux/errno.h is already included a few lines above.
> 

Good point! With that nit addressed:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.


