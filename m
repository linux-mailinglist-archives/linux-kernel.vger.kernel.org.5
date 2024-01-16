Return-Path: <linux-kernel+bounces-27344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05282EE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B301F2832F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFCB1BC2A;
	Tue, 16 Jan 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="J5MWO03g"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E81BC20
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3608e206f27so53758625ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1705405490; x=1706010290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82O4LLMvvZQSOIR03ZK1ZHOCta6qzNNSpbUP83yxRKg=;
        b=J5MWO03gkVZLZZG9GhcXLT6/CP+jCJvKGD/0XVjzUGWYUC1ub/07lT/EDFVvo0+vQk
         NWuUMIagKr0Td5N/FbpJQbpYYZZGjMGEJoVXrVt7CO6rVWROPF/uUAEh2zb3zxPlTxXM
         1Bo/ta1GcDGr8cykFRZM/7OSvdRpB50qv6cpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705405490; x=1706010290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82O4LLMvvZQSOIR03ZK1ZHOCta6qzNNSpbUP83yxRKg=;
        b=U9NYKu9uY32agHpDoOPK5lvzhmJzZwYV35Fy5NCouKaX6BFRgeySst0JXulcuCQqSG
         ETrS8XTpBpXX9pi4VB1eBKAC9nZOnMEkieyJhFAYsmEc8Gi6clAq+1+C1WCCkPJ+3DY0
         KdYynyT+5aQodKYXVQCfjl+V3Alrg6BFhN6IalziyDKwQx4QC3kInAF0aHqHNs81co6A
         XrVSJf1MjtdPh7FAjQItHodzV/g0zpM/jGEY/bU5ZGjnsRaUKfWM9yIho0saybimbSjq
         bn+LIl1Iq/TvqLoYdo8toUQFd0S9Dtn4pO7Y8eLTfLjjoB/xnwuzU+tfQWg4q4uo0CH+
         uqTg==
X-Gm-Message-State: AOJu0Yy4hlk30QoVDXGjeXxhsnoY/6457FHg/FrWQQ4LakiR92ttrUI9
	2/xmxcoKw42keOrwuXBkytkyKtYXnbx8
X-Google-Smtp-Source: AGHT+IExKL8eb+NEQah+KUXQe8TLYefHOat3TNlc6xHDt0chTP1l2cR0IV/yZj9etX1oe+OTovZLtQ==
X-Received: by 2002:a92:c9c5:0:b0:360:d9d9:a8a3 with SMTP id k5-20020a92c9c5000000b00360d9d9a8a3mr3693194ilq.117.1705405490139;
        Tue, 16 Jan 2024 03:44:50 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id 14-20020a92130e000000b0035fadef5006sm3504193ilt.26.2024.01.16.03.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:44:49 -0800 (PST)
Message-ID: <51e73530-7c65-4e2f-9749-7dbbe9098fde@ieee.org>
Date: Tue, 16 Jan 2024 05:44:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: ipa: remove the redundant assignment to
 variable trans_id
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Alex Elder <elder@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240116114025.2264839-1-colin.i.king@gmail.com>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240116114025.2264839-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 5:40 AM, Colin Ian King wrote:
> The variable trans_id is being modulo'd by channel->tre_count and
> the value is being re-assigned back to trans_id even though the
> variable is not used after this operation. The assignment is
> redundant. Remove the assignment and just replace it with the modulo
> operator.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'trans_id' is used in the
> enclosing expression, the value is never actually read from
> 'trans_id' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

This looks good.  I saw this before but hadn't gotten around to
fixing it yet.  Thank you!

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/net/ipa/gsi_trans.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
> index ee6fb00b71eb..f5dafc2f53ab 100644
> --- a/drivers/net/ipa/gsi_trans.c
> +++ b/drivers/net/ipa/gsi_trans.c
> @@ -247,7 +247,7 @@ struct gsi_trans *gsi_channel_trans_complete(struct gsi_channel *channel)
>   			return NULL;
>   	}
>   
> -	return &trans_info->trans[trans_id %= channel->tre_count];
> +	return &trans_info->trans[trans_id % channel->tre_count];
>   }
>   
>   /* Move a transaction from allocated to committed state */


