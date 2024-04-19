Return-Path: <linux-kernel+bounces-151039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BA8AA83C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A319283A06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91DC8DE;
	Fri, 19 Apr 2024 06:07:56 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E621C121;
	Fri, 19 Apr 2024 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506876; cv=none; b=X2vTPiWcjjDFFrDrxRmTz1vLbixx4r7E+R/tBZS6NNXbL5OcD1Duh/7/wy9WikQKCKTyLCql2Pi+IaKWsdklpQFwJBxMrLPXa6zGupZ0kYfKf5zXNbpzKv6Qm6WTHFcA0qEhLkjkeMO6XOR3Ii57BqhsVS+e4AxhORCxpOonSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506876; c=relaxed/simple;
	bh=e8rL9wQCtwcp4ehgNV78lMdeWlBU1r4R6whdUxLxkEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrGlqw0xVzy4HJ9Ej989nSIMFou+KX188j4A2g+fJwnN7f2k+egs/ToHLoXmkvWbQKjh8+efujg4QhZSJg5Vh2iiUPX1we3N6UZz1jGOVWufqpStGgkJDfMkoqK1uqC1LbRRC3ScQgczdx5U6N7f1qA1plnNVWaMvYXxFhP6Aac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a523524e5baso165404866b.3;
        Thu, 18 Apr 2024 23:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506873; x=1714111673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QFAFdaeQGhdEPu7ZDYV3U7ePwFNPLImZP7cCf8biZg=;
        b=KV6IyJVpwEyujCNjxuDwFyngesnYGk9OthWXeyq1lf36UCdo+zI3e4UDUel5QvmoXg
         njq4CmQrYyj4G2a9Q7N8/8AbXp48w1VqlB3Motkkbm0LJ5mKgQ1nmfwtjLPP6SyST6OC
         WYZZOJf+WLdGOIRpD6WY9BKhpgmReMOZ5oiGQXVPJyTyP+eAtjWEiuIJkuvDWb8MQt/g
         FFC0VfQwJgrZ1AHU1OnM8nv8Ye1ZVR8IIzMETvq675czSHFDjDaWEUglX0EfunTFp1Ci
         oPpHzXN8/ERKAWGsTuRNlxBH31WkxRPCo5ly7sE7SfOB3koIYMQ3KrTI500h2KGuQYzY
         FoUA==
X-Forwarded-Encrypted: i=1; AJvYcCWfQa6a1EUxC6RcZgFMwKlQHTMU5DwyVPKnAEIK749JoQYRsl6dNPFY7WMr8MQdUv3HC+pD0AdXrjg5ODmIHiAfoEDeObtjBsm9qS4yoZTV9X1naGjMRJ/ruN8DKlT5y8PS9vHhj0Una+wg
X-Gm-Message-State: AOJu0YwpLICFcKCTnYNhQDcIVlK0IzXp5cdYK6LVYx6IxsYbol2BgQqK
	Sz5PNQLFQSghyrCUxy0OvUIHnkK5rPhK4xY6t6iT+/xJhQuRjptbW1EQvG1r
X-Google-Smtp-Source: AGHT+IHfYbwFSZHp4nTkSxcXJI/0+mqiUsW6BNDF/1+v1th/hc3R51Sgae0vQXJTDrsm722SblYJ3A==
X-Received: by 2002:a17:906:c9d5:b0:a51:a547:c21f with SMTP id hk21-20020a170906c9d500b00a51a547c21fmr1009664ejb.5.1713506872363;
        Thu, 18 Apr 2024 23:07:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id hg7-20020a170906f34700b00a4e5a6b57a2sm1738093ejb.163.2024.04.18.23.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 23:07:51 -0700 (PDT)
Message-ID: <379d43bd-d5eb-4877-8781-888c82821bb8@kernel.org>
Date: Fri, 19 Apr 2024 08:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] serial: exar: change port_type ternary line
 wrapping
To: Parker Newman <parker@finest.io>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <cover.1713452766.git.pnewman@connecttech.com>
 <0081b6a7bbe1ad6ce114132f9ee86677a761de6d.1713452766.git.pnewman@connecttech.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <0081b6a7bbe1ad6ce114132f9ee86677a761de6d.1713452766.git.pnewman@connecttech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 04. 24, 17:36, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Change line wrapping of ternary operators in
> cti_get_port_type_xr17c15x_xr17v25x() for better readability.
> 
> Old example:
> 
> 	port_type = port_num == 0 ?
> 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> 
> New:
> 	port_type = port_num == 0 ? CTI_PORT_TYPE_RS232 :
> 				CTI_PORT_TYPE_RS422_485;

This is worse IMO. Ilpo suggested a bit different alignment. But still...

> Based on feedback from:
> Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com

You should have CCed the author.

> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>   drivers/tty/serial/8250/8250_exar.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 10725ad0f3ef..a76b4e5bab4e 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -741,19 +741,19 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
>   		break;
>   	// 1x RS232, 1x RS422/RS485
>   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
> -		port_type = port_num == 0 ?
> -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		port_type = port_num == 0 ? CTI_PORT_TYPE_RS232 :
> +					CTI_PORT_TYPE_RS422_485;


Well, could you initialize port_type = CTI_PORT_TYPE_RS232? And here do 
only:
if (port_num > 0)
     return CTI_PORT_TYPE_RS422_485;
?


>   		break;
>   	// 2x RS232, 2x RS422/RS485
>   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
> -		port_type = port_num < 2 ?
> -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		port_type = port_num < 2 ? CTI_PORT_TYPE_RS232 :
> +					CTI_PORT_TYPE_RS422_485;

And so on.

>   		break;
>   	// 4x RS232, 4x RS422/RS485
>   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
>   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> -		port_type = port_num < 4 ?
> -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		port_type = port_num < 4 ? CTI_PORT_TYPE_RS232 :
> +					CTI_PORT_TYPE_RS422_485;
>   		break;
>   	// RS232/RS422/RS485 HW (jumper) selectable
>   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
> @@ -789,13 +789,13 @@ static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *p
>   		break;
>   	// 6x RS232, 2x RS422/RS485
>   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> -		port_type = port_num < 6 ?
> -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		port_type = port_num < 6 ? CTI_PORT_TYPE_RS232 :
> +					CTI_PORT_TYPE_RS422_485;
>   		break;
>   	// 2x RS232, 6x RS422/RS485
>   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> -		port_type = port_num < 2 ?
> -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		port_type = port_num < 2 ? CTI_PORT_TYPE_RS232 :
> +					CTI_PORT_TYPE_RS422_485;
>   		break;
>   	default:
>   		dev_err(&pcidev->dev, "unknown/unsupported device\n");
> --
> 2.43.2
> 

-- 
js
suse labs


