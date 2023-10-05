Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA507BA760
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjJERMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjJERMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:12:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B55D7F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:00:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F88DC433C7;
        Thu,  5 Oct 2023 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696525218;
        bh=86XiYA1FQuVR5BbSaxpdLp3LI/kn4PquHymjBZnaAGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkzvrZcXSuO6dkHKbfhmj2MQDc9eItvUA+dCBgFPijJKavlS3UZx6HzUyZrBCkzfe
         S68tUG/+EhoKPP46VVEVGDEyU/bQ+uwpK8ZXOq7WWO18q0sxfzSqLjKQWA2YJujXw6
         3P9fKYItthZ6yeCLDGXIQnGLWBVvmbjvZrGzJvStigB2HwZyCOis5TCWv7TPS9zoyo
         9konQVRUToAETGLHNem15eX/4HvTfI8NtT7ZJYAMJt9YOmdd9wurvAKfVBqtD2Ve6P
         ZBk/snSAaVbHwyXWg85gX0dQs14MZRGCYv2lnYQxgkM0VvqtSE6bLu+Pud7IlqYnQk
         xJBtXtwo9kLLg==
Date:   Thu, 5 Oct 2023 18:00:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
Message-ID: <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk>
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLnAbS/VBTaPciER"
Content-Disposition: inline
In-Reply-To: <20231005133059.917577-1-naresh.solanki@9elements.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLnAbS/VBTaPciER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 05, 2023 at 03:30:58PM +0200, Naresh Solanki wrote:

>  static int _notifier_call_chain(struct regulator_dev *rdev,
>  				  unsigned long event, void *data)
>  {
> +	const char *name;
> +	int ret;
> +
>  	/* call rdev chain first */
> -	return blocking_notifier_call_chain(&rdev->notifier, event, data);
> +	ret =  blocking_notifier_call_chain(&rdev->notifier, event, data);
> +
> +	if (event & REGULATOR_EVENT_VOLTAGE_CHANGE) {
> +		name = dev_attr_microvolts.attr.name;
> +		sysfs_notify(&rdev->dev.kobj, NULL, name);
> +	} else {
> +		name = dev_attr_status.attr.name;
> +		sysfs_notify(&rdev->dev.kobj, NULL, name);
> +	}

We probably should filter the events more, there's events for pre and
post voltage change for example which aren't status changes so would be
spurious.  It ought not to break anything but we should still avoid
unneeded work.

--SLnAbS/VBTaPciER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUe65gACgkQJNaLcl1U
h9DCfwf+LUhbXlkKauGCY8NjdxnbdbEs6qPtGac8GoQu/08ZVd20WijGczYB6m3I
rDeSPqqkkzlC18VK2tWXRk7vjduLLYs8gTWDb1KC60000IKsDj6uI4SpzPq9d7UW
p8dj2XRTOfo+mgvQVD8N7JXDixYNDAafKZema+7Lj3oBdvOaIpiCca430OOUYakQ
WZwGIEcundZ9lietQKUVwXRNhS33htfUlGq9C+nVYi/hk0f8SlXaC0QubuHPiZME
2278Qlh56aIki9vMq7SLWWv1TBnHasAV3BVFINzCfYNaf2sDPFDEKSM4R9zxkv1U
mbWfL4ZlYnuh0ZqS9t3EU71YK87zjQ==
=az4C
-----END PGP SIGNATURE-----

--SLnAbS/VBTaPciER--
