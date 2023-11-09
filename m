Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEEF7E71A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345010AbjKISkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKISkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:40:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F32D44;
        Thu,  9 Nov 2023 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ULD1o8HAQA2e01odwC++rslK041lXV0jsWzE+hlK8Vs=;
        t=1699555220; x=1700764820; b=mmSeIQ+U2o8ntltkPIma6cMqrSMEbufzQMKMR0IcxjhcNb/
        s+lDUZhWEKBUeAdv8azTY/c6CIwt2xzbzUB3sQqR4Yt64XYvEFlGzmp2DZoK8phgv9z36vl9uucwM
        Haz11BppNOs14/6FrRcqe7ZX/w1X6AJm3hjGPYnx5j8itTyuYWj+VGU73040rnHpP7oWfp+AfUCkA
        6kS2kqltcM0f7ayFXEVoyqVw90BbceYI957COpncHblmlMl0q+DHcIYlpGEjG6Tkz4ok7uYJO/XyT
        gSXM67rjvT6qQVMfDeyE7XaCEOqzuMQNQTM99t1cIZGRHTLMnfSOFNnA/BLkwvcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r19wv-00000001v0g-18Yh;
        Thu, 09 Nov 2023 19:40:17 +0100
Message-ID: <33254d48b38755e924cdae30bffdf5bc9b6bccd1.camel@sipsolutions.net>
Subject: Re: [PATCH] debugfs: only clean up d_fsdata for d_is_reg()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolai Stange <nicstange@gmail.com>
Date:   Thu, 09 Nov 2023 19:40:16 +0100
In-Reply-To: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
References: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-09 at 16:06 +0100, Johannes Berg wrote:
>=20
> @@ -734,6 +725,11 @@ static void __debugfs_file_removed(struct dentry *de=
ntry)
>  		return;
>  	if (!refcount_dec_and_test(&fsd->active_users))
>  		wait_for_completion(&fsd->active_users_drained);
> +
> +	/* this no longer matters */
> +	dentry->d_fsdata =3D NULL;
>=20

That's not true, and therefore this patch is wrong -
full_proxy_release() still happens later.

Not sure why I didn't see that originally, even in tests.

I'll try again :)

johannes
