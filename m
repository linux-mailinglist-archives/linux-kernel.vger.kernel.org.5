Return-Path: <linux-kernel+bounces-85033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1A86AF65
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C44A286AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F41487DF;
	Wed, 28 Feb 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCED7HzD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCE36129;
	Wed, 28 Feb 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124488; cv=none; b=pfY/jBa/48sQU4sjR5nK1baKueccR5WwtVjFNXUDOjXGk4fBhknnO89kFKNziCLRksYN2NONZQPSqWzXI+0k3nypsnWiESfyuIar9aAiAKRI/XU9pMbuUnsQhKB3d3hxWpjzipRcszUmZKu4Q3M6PKorYUI4lETC82HyQfo3W+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124488; c=relaxed/simple;
	bh=K6KGP6T+SeD5Hx1HsZoWXozDmI8OLiyMag16ZeWLf2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUu/h89Ah6QJAyyiM/XGIaHsv0Kb9mVkSltxacHXuOKYKv6acW1dBcqRuSMqiNktsDhDIBxj352nxJVZQYkiMc4M5FWAe2JMhftRRmb25/kFBY0gRZjZbPDmR2C0HH+PF0kObmAykRz3wYuLJRNVewIP67t/wxboP/T0MpHM4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCED7HzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D38C433F1;
	Wed, 28 Feb 2024 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709124487;
	bh=K6KGP6T+SeD5Hx1HsZoWXozDmI8OLiyMag16ZeWLf2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCED7HzDG5k8ELHuyoPVxRyOYEQTXmRFY04WKTQzFUxz3sw3Xil8/pRwRReUClr8C
	 Fy7I1c398Aa9uLvKB6m8sirKyWFn0IS2QyN7IzssOrmtI6Jf55FcAffiyV/EndLsn2
	 aSqbUrG2vgSX0U4Iwg23IpvxLMrAHAAf9SyMNx8rgcZcIUaN2icArxDLoUL75wKQs/
	 QEOQdj8WJjWmCOzFioRZ++C1YuXkZ0u+CJfmDnzbowesx8FwrWSf/w7eeX8CiFY6qH
	 3KmP+YUHyB72wjm+K0o4YIeAwZuNAUr+AjphgTCPnu37XBvft7rLiiDR4QDHllkZEX
	 ssKmzRSGXALjA==
Date: Wed, 28 Feb 2024 12:48:01 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240228124801.GC292522@kernel.org>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>

On Tue, Feb 27, 2024 at 03:42:55PM +0100, Kory Maincent wrote:

..

> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> index 522115cc6cef..a3e297cc2150 100644
> --- a/include/linux/pse-pd/pse.h
> +++ b/include/linux/pse-pd/pse.h
> @@ -55,10 +55,10 @@ struct pse_controller_ops {
>  	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
>  		unsigned long id, struct netlink_ext_ack *extack,
>  		struct pse_control_status *status);
> -	int (*ethtool_set_config)(struct pse_controller_dev *pcdev,
> -		unsigned long id, struct netlink_ext_ack *extack,
> -		const struct pse_control_config *config);
>  	int (*setup_pi_matrix)(struct pse_controller_dev *pcdev);
> +	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
> +	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
> +	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);

Hi Kory,

Please update the Kernel doc for struct pse_controller_ops to reflect the
added and removed fields.

>  };
>  
>  struct module;
> @@ -90,10 +90,14 @@ struct pse_pi_pairset {
>   *
>   * @pairset: table of the PSE PI pinout alternative for the two pairset
>   * @np: device node pointer of the PSE PI node
> + * @rdev: regulator represented by the PSE PI
> + * @enabled: PI enabled state
>   */
>  struct pse_pi {
>  	struct pse_pi_pairset pairset[2];
>  	struct device_node *np;
> +	struct regulator_dev *rdev;
> +	bool enabled;
>  };
>  
>  /**
> @@ -107,6 +111,8 @@ struct pse_pi {
>   * @of_pse_n_cells: number of cells in PSE line specifiers
>   * @nr_lines: number of PSE controls in this controller device
>   * @lock: Mutex for serialization access to the PSE controller
> + * @lock_owner: current owner of the mutex
> + * @ref_cnt: mutex's reference count

These newly documented fields don't seem to exist in struct
pse_controller_dev. Perhaps this is an left over from earlier development?

>   * @types: types of the PSE controller
>   * @pi: table of PSE PIs described in this controller device
>   * @of_legacy: flag set if the pse_pis devicetree node is not used
> @@ -132,7 +138,8 @@ struct device;
>  int devm_pse_controller_register(struct device *dev,
>  				 struct pse_controller_dev *pcdev);
>  
> -struct pse_control *of_pse_control_get(struct device_node *node);
> +struct pse_control *of_pse_control_get(struct device *dev,
> +				       struct device_node *node);
>  void pse_control_put(struct pse_control *psec);
>  
>  int pse_ethtool_get_status(struct pse_control *psec,
> @@ -147,7 +154,8 @@ bool pse_has_c33(struct pse_control *psec);
>  
>  #else
>  
> -static inline struct pse_control *of_pse_control_get(struct device_node *node)
> +static inline struct pse_control *of_pse_control_get(struct device *dev,
> +						     struct device_node *node)
>  {
>  	return ERR_PTR(-ENOENT);
>  }
> 
> -- 
> 2.25.1
> 
> 

