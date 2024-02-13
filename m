Return-Path: <linux-kernel+bounces-63515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E126E8530A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119E21C2612E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C92EB12;
	Tue, 13 Feb 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWR040Ze"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F43AC0F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827948; cv=none; b=GAxRIiv7voESLEzQe/PxrNs81t+5dv+/avUklLPlRjERzXyNGLV/pysfwhVyePvHE8QthYDGyL91lYUO4U5j/0mXJu9yp8w/18fp5FYgyZSZ79PBCbn/ycfMY6X9tWYUCasuBVVdEffnvoBskb4+KqylrTg++iLiLfaxeOgfk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827948; c=relaxed/simple;
	bh=SlAr4gRM50t3S0zyV35U8IQUUz1VcAS6ZIt3HI4m0Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNFiNfm8AskB6AJT4xsdntdbLUunoOisW1c/ZcAZsiGZ6LzEHsvVUTtj34jS76DLUeb6q0AqUbFYjsfx96YGZiKttA29oyeRUHO+AygIAcQ2f+5PvHXZ9yyZiaTAF9WMNp3S2+pxh6v994Vbu2eq8aNyAXYkG8TOqYEeI1aPFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QWR040Ze; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-411a5a86078so9464575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707827945; x=1708432745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaVbEZfAWFUn15hfNw2DqAVWI2aKfMatPCtinVQjhmM=;
        b=QWR040ZeqDFkr1Rn4c0eVGz9iyuB3l6jq1Qvfa+438CGz4xdZR/k+vf6B2JyhIMhLs
         8xdbcNjW8XlQyxLVLxwQ9gvo3hQPc8G5Wyh2EDPbseZ5/Sffry8oyoHfBPbz7V66LSKt
         2vsihGtbqubZfAEhowRhglfc/2mD2dUc4ier4d/EVXc9ePiF94d7QfjnHAaFu04cvOzJ
         uXVcN8TSWVJH35nLsvFazetLmKNxm+gRviwygtW/CpJ3zWjh9aThJVP/G7GUXgwfNNVZ
         JgFaIDIS6fIqG4JeHYySKbgr7NuEkro0Zzfus9WNi7Gt/6bLt5yp3qQeO1x+oFzvhSza
         CZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827945; x=1708432745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaVbEZfAWFUn15hfNw2DqAVWI2aKfMatPCtinVQjhmM=;
        b=Gf7S58qmHQUyhFJvGIk3G6eqpKsqkz75sJjHn3HN5I2Dz9EoSgG/JR4thblUzHlZIP
         APZ3mJBvLf3CFezPySM1YfOoogAsJLDh84agwO5xRqRma3Jqr0f7nYYy6poa5XI/iGqf
         XzPLdBZJC/HVOcFe5M2wqn38DNy3DPl5ug5S+WIwQ56QM3E3HFaopmknKH99vn7kqGds
         abMgX1aN6I21oy+yFEzsrDm04l8vJ/7rFMYV7bA8GZJ7wumc7MEDMMwnlGXeri5mqf9Z
         k3kTABGjAaeabcbAlCsodELMXxurUQp2fvwq+Ss7/lUYe9CMbeo7Qq4SmD3yVEwWTuxd
         fpzg==
X-Forwarded-Encrypted: i=1; AJvYcCVI/+J5Fy7PUOgAzaZqxWt3tq2wB5AMhpRNVIim8xIkBg/36iQMUPICrKYA2alMsdvCPLMq1TimHOHQeBaUFbSfRMwI+bY7BdN3evdp
X-Gm-Message-State: AOJu0YyofdQEeB0nvqz4l/KKzBXdZWiYj1dHAqGSxPtCmkT9LVMsVoWk
	H4CoIg14TqAk7TVRPhNlMO8Xa4ZYl0tlR9XBYjIo6sRIAPAXKQGOTMzs88A/fps=
X-Google-Smtp-Source: AGHT+IGM5jOc+CvYkWNtW+q24shmt8jWjC/clmI27TBdzd7L3O/O9PDagYuKLivfpF7TOwLapfyQ7w==
X-Received: by 2002:a05:600c:5006:b0:410:df8f:9ffa with SMTP id n6-20020a05600c500600b00410df8f9ffamr3118125wmr.25.1707827945222;
        Tue, 13 Feb 2024 04:39:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwfG/25VdRnRabJGrDJ1foRjhAgw7vLJP6SeYqRWi5yd4eH/UyM+cdU/+7sRfWyWJVvM6qQW7uOQi06sSx7edsRVN/jQmIX+qQcaR6uELvXfOfd2n6pYHq0PO1Ta8Pj/BZ5p+kq/Ir+WQ5+1w2uKpDvHPJPRN192hWXjwf1uYU+zbQPRWr2Cne79ejxJzNMoRMxeGgCvYVymBwV6UnWcszrfnzLNn9m6vs4cN7f8HV7Oh1FwqjdzGbde1H4NZmsYd5fm7hmVsI1EfV28gGi32Y8m76hHCOtuMxgqefpLiz/0nTLH9OOYRc
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id je11-20020a05600c1f8b00b00410885ba8casm10436092wmb.39.2024.02.13.04.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 04:39:04 -0800 (PST)
Message-ID: <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
Date: Tue, 13 Feb 2024 12:39:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/9/24 13:51, Théo Lebrun wrote:
> Current behavior is that spi-mem operations do not increment statistics,
> neither per-controller nor per-device, if ->exec_op() is used. For
> operations that do NOT use ->exec_op(), stats are increased as the
> usual spi_sync() is called.
> 
> The newly implemented spi_mem_add_op_stats() function is strongly
> inspired by spi_statistics_add_transfer_stats(); locking logic and
> l2len computation comes from there.
> 
> Statistics that are being filled: bytes{,_rx,_tx}, messages, transfers,
> errors, timedout, transfer_bytes_histo_*.
> 
> Note about messages & transfers counters: in the fallback to spi_sync()
> case, there are from 1 to 4 transfers per message. We only register one
> big transfer in the ->exec_op() case as that is closer to reality.
> 
> This patch is NOT touching:
>  - spi_async, spi_sync, spi_sync_immediate: those counters describe
>    precise function calls, incrementing them would be lying. I believe
>    comparing the messages counter to spi_async+spi_sync is a good way
>    to detect ->exec_op() calls, but I might be missing edge cases
>    knowledge.
>  - transfers_split_maxsize: splitting cannot happen if ->exec_op() is
>    provided.
> 
> Testing this patch:
> 
>    $ cd /sys/devices/platform/soc
>    $ find . -type d -path "*spi*" -name statistics
>    ./2100000.spi/spi_master/spi0/statistics
>    ./2100000.spi/spi_master/spi0/spi0.0/statistics
>    $ cd ./2100000.spi/spi_master/spi0/statistics
> 
>    $ for f in *; do printf "%s\t" $f; cat $f; done | \
>          grep -v transfer_bytes_histo | column -t
>    bytes                    240745444
>    bytes_rx                 240170907
>    bytes_tx                 126320
>    errors                   0
>    messages                 97354
>    spi_async                0
>    spi_sync                 0
>    spi_sync_immediate       0
>    timedout                 0
>    transfers                97354
>    transfers_split_maxsize  0
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/spi/spi-mem.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 2dc8ceb85374..171fe6b1c247 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -297,6 +297,50 @@ static void spi_mem_access_end(struct spi_mem *mem)
>  		pm_runtime_put(ctlr->dev.parent);
>  }
>  
> +static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
> +				 const struct spi_mem_op *op, int exec_op_ret)
> +{
> +	struct spi_statistics *stats;
> +	int len, l2len;
> +
> +	get_cpu();
> +	stats = this_cpu_ptr(pcpu_stats);
> +	u64_stats_update_begin(&stats->syncp);
> +
> +	/*
> +	 * We do not have the concept of messages or transfers. Let's consider
> +	 * that one operation is equivalent to one message and one transfer.
> +	 */
> +	u64_stats_inc(&stats->messages);
> +	u64_stats_inc(&stats->transfers);
> +
> +	/* Use the sum of all lengths as bytes count and histogram value. */
> +	len = (int)op->cmd.nbytes + (int)op->addr.nbytes;
> +	len += (int)op->dummy.nbytes + (int)op->data.nbytes;

spi_mem_check_op() makes sure that op->cmd.nbytes != 0, otherwise it
returns -EINVAL ...

> +	u64_stats_add(&stats->bytes, len);
> +	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;

.. thus l2len can never be negative. You can declare len and l2len as
u64. The casts from above shall disappear.

> +	l2len = max(l2len, 0);
> +	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
> +
> +	/* Only account for data bytes as xferred bytes. */

s/xferred/transferred?

> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> +		u64_stats_add(&stats->bytes_tx, op->data.nbytes);
> +	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
> +		u64_stats_add(&stats->bytes_rx, op->data.nbytes);
> +
> +	/*
> +	 * A timeout is not an error, following the same behavior as
> +	 * spi_transfer_one_message().
> +	 */
> +	if (exec_op_ret == -ETIMEDOUT)
> +		u64_stats_inc(&stats->timedout);
> +	else if (exec_op_ret)
> +		u64_stats_inc(&stats->errors);
> +
> +	u64_stats_update_end(&stats->syncp);
> +	put_cpu();
> +}
> +
>  /**
>   * spi_mem_exec_op() - Execute a memory operation
>   * @mem: the SPI memory
> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		 * read path) and expect the core to use the regular SPI
>  		 * interface in other cases.
>  		 */
> -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> +

Would be good to be able to opt out the statistics if one wants it.

SPI NORs can write with a single write op maximum page_size bytes, which
is typically 256 bytes. And since there are SPI NORs that can run at 400
MHz, I guess some performance penalty shouldn't be excluded.

>  			return ret;
> +		}
>  	}
>  
>  	tmpbufsize = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
> 
> ---
> base-commit: 19b50f80b3a4865bd477aa5c026dd234d39a50d2
> change-id: 20240209-spi-mem-stats-ff9bf91c0f7e
> 
> Best regards,

