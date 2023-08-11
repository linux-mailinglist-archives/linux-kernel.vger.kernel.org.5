Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B0778679
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 06:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjHKEY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 00:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHKEY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E983213B;
        Thu, 10 Aug 2023 21:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5D9762C26;
        Fri, 11 Aug 2023 04:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C27C433C7;
        Fri, 11 Aug 2023 04:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691727865;
        bh=tFTch+Vt3hmXVV5W6NxEILrRRxKFsve4GjiYPL3bFxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDwSTMykeWxpIGLeOu3IiYkMhslf3W0y9Wd7xmQudpL+OJX6C2GX3kZkJzcIPO0AQ
         Bh9FzaJP6YfG6qeTg3ulmo0/+YSn8TQ4CJSlv44kV7jKQVjZnpxZoEbawJ83Ns+sD+
         s+eSVrjCTmW+8Ais4F+9lsn1QSbgeRvh9HMLNdNXu3osjyDo2T4OPY7GMsIFmNE9V6
         OBaHWJ6EEBKvhFqyHprATLQeyixBG6wAYb8j9pnQvm2UOhjiUGH519JqOlBKseeRjm
         tpu7AufenVwScWolHFut7isQfj5tTE2TGkA7Bj4iwJ4gQoufZ5ZFcX1NnKnxJYoH50
         zk8bxUwLkhfbQ==
Date:   Thu, 10 Aug 2023 21:24:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/6] crypto: crc64 - add crc64-iso framework
Message-ID: <20230811042423.GA1295@sol.localdomain>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230719-mcrc-upstream-v2-2-4152b987e4c2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-mcrc-upstream-v2-2-4152b987e4c2@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:58:49AM +0530, Kamlesh Gurudasani wrote:
> diff --git a/lib/crc64-iso.c b/lib/crc64-iso.c
> new file mode 100644
> index 000000000000..d6e803124fa0
[...]
> +u64 crc64_iso_update(u64 crc, const unsigned char *buffer, size_t len)
> +{
> +	struct {
> +		struct shash_desc shash;
> +		u64 crc;
> +	} desc;
> +	int err;
> +
> +	if (static_branch_unlikely(&crc64_iso_fallback))
> +		return crc64_iso_generic(crc, buffer, len);
> +
> +	rcu_read_lock();
> +	desc.shash.tfm = rcu_dereference(crc64_iso_tfm);
> +	desc.crc = crc;
> +	err = crypto_shash_update(&desc.shash, buffer, len);
> +	rcu_read_unlock();
> +
> +	WARN_ON_ONCE(err);
> +
> +	return desc.crc;
> +}
> +EXPORT_SYMBOL_GPL(crc64_iso_update);
> +
> +u64 crc64_iso(const unsigned char *buffer, size_t len)
> +{
> +	return crc64_iso_update(0, buffer, len);
> +}
> +EXPORT_SYMBOL_GPL(crc64_iso);

These functions are never called.

Why are you trying to add unused code to the kernel?

- Eric
