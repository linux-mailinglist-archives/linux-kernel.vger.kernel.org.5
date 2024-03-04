Return-Path: <linux-kernel+bounces-91034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7454B8708B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD94285006
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B1E61680;
	Mon,  4 Mar 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwP2OMTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3F612DF;
	Mon,  4 Mar 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574772; cv=none; b=huPJD0CMcrnmkV4d658J21T8k+bdxzrktBAEEw3Qxjoil1St8kfGWD2JY9msC/7xdFK4UVlQhPamkIe0im+th0M/7BJ/qCiQvplh0OLon8J5XiIfysAZSGmsqBkEN4D/BhQGKiGWJJd2I8X9TtGLNyrGxrE7yWloaEE3GtC+h6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574772; c=relaxed/simple;
	bh=+2nW+kM+psMXjX7OixfRQdXXvudhq9x7ueFtJmPJqj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljLT08ifQsaUhxvD3BnalnJORiSNC/R83QkJIbUBzawTjTpCSp1AUhwxCGsuH4oJhCcqNXiB8BXoDtG8qNmwCarp0KigkUqziRuqzB7N0e8NnUWtWq4UjvUlRMAPzlw0XrV92J8zlyz8UWVDnraAHFNT0Vd2swFecg1YjnD7l0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwP2OMTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6959C433C7;
	Mon,  4 Mar 2024 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709574772;
	bh=+2nW+kM+psMXjX7OixfRQdXXvudhq9x7ueFtJmPJqj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwP2OMTAv7vZyy/L6rRHno7DiEO56zO1MHkRwqAscvOhfwB4WhJL3cizW8llsngVo
	 lpZFlVdd7QMfCJBIXrpVz/qA0oA3Lz2c+ld1VzRzWAMCgpCBWbgvfsUmoumVYEeIXl
	 BDE4nhu8acyCXQSgZMCoB33r18URCfg87IN0NNerX67/AkCEHaE6T6rUv4QLmHLyki
	 4Lle7h7rNbXFoglQsb1PBhbV/WItbRgx7i5kvpeH/ImZxzK97BWGMlQrI4+1KiRe2/
	 xT5eCnNNjZ9wyUivIh++/uq9SA+RHn+RFlubSsNmOD+17UieGCw5aDZfzQt/g2HrzJ
	 rrqNtu0JelutA==
Date: Mon, 4 Mar 2024 17:52:46 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH net-next 2/6] net: wan: framer: make framer_class constant
Message-ID: <20240304175246.GO403078@kernel.org>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
 <20240302-class_cleanup-net-next-v1-2-8fa378595b93@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302-class_cleanup-net-next-v1-2-8fa378595b93@marliere.net>

+ Herve Codina <herve.codina@bootlin.com>

On Sat, Mar 02, 2024 at 02:05:58PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the framer_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/wan/framer/framer-core.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/framer-core.c
> index 33b358b99f70..f547c22e26ac 100644
> --- a/drivers/net/wan/framer/framer-core.c
> +++ b/drivers/net/wan/framer/framer-core.c
> @@ -18,7 +18,12 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> -static struct class *framer_class;
> +static void framer_release(struct device *dev);
> +static const struct class framer_class = {
> +	.name = "framer",
> +	.dev_release = framer_release,
> +};
> +
>  static DEFINE_MUTEX(framer_provider_mutex);
>  static LIST_HEAD(framer_provider_list);
>  static DEFINE_IDA(framer_ida);
> @@ -627,7 +632,7 @@ struct framer *framer_create(struct device *dev, struct device_node *node,
>  	INIT_DELAYED_WORK(&framer->polling_work, framer_polling_work);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&framer->notifier_list);
>  
> -	framer->dev.class = framer_class;
> +	framer->dev.class = &framer_class;
>  	framer->dev.parent = dev;
>  	framer->dev.of_node = node ? node : dev->of_node;
>  	framer->id = id;
> @@ -741,7 +746,7 @@ struct framer *framer_provider_simple_of_xlate(struct device *dev,
>  	struct class_dev_iter iter;
>  	struct framer *framer;
>  
> -	class_dev_iter_init(&iter, framer_class, NULL, NULL);
> +	class_dev_iter_init(&iter, &framer_class, NULL, NULL);
>  	while ((dev = class_dev_iter_next(&iter))) {
>  		framer = dev_to_framer(dev);
>  		if (args->np != framer->dev.of_node)
> @@ -870,14 +875,6 @@ static void framer_release(struct device *dev)
>  
>  static int __init framer_core_init(void)
>  {
> -	framer_class = class_create("framer");
> -	if (IS_ERR(framer_class)) {
> -		pr_err("failed to create framer class (%pe)\n", framer_class);
> -		return PTR_ERR(framer_class);
> -	}
> -
> -	framer_class->dev_release = framer_release;
> -
> -	return 0;
> +	return class_register(&framer_class);
>  }
>  device_initcall(framer_core_init);
> 
> -- 
> 2.43.0
> 
> 

