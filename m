Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2F80A4A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573823AbjLHNpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjLHNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:45:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F604172B;
        Fri,  8 Dec 2023 05:45:57 -0800 (PST)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5598D66073AA;
        Fri,  8 Dec 2023 13:45:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702043156;
        bh=twSl3vT3zaZOdj4/451frioqLeLg5HRJipbHbe5yGRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHxhVN/miACQglCgDJJ8KpCp4r5TuOFV3zlVxcj+i76dTjmr+mUknqzmiXJN46EMo
         qos6VZNCBpn1Xrbsulcn5g+07kXLOEw5xckSHHnWsRtuOE/LXvcD3rf29xPswdqhMV
         Fmjz7jmp2jqiRMhXfgP4H0/kQ4hxkfDkd+xfpyinLZTNage0D1EnsihwWGv8AHsUJq
         aHh1R+XXURD+wKT8PEQIT2G+JxNEoqN27hzVwpC271BwLQxTv8lmJY+MHCdvBU5yhM
         HjvRfSDGkrDxHL555YvFqxEswB/WEF76NqWJUvySMXqNQ9+zyqgZLJIxzn72ygSjG+
         vmT81RHMKJxgw==
Date:   Fri, 8 Dec 2023 10:45:46 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, kernelci@lists.linux.dev,
        kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <e9772963-56e8-4465-9c29-3a2955b6f546@notapiano>
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <20230828211424.2964562-4-nfraprado@collabora.com>
 <310391e8-fdf2-4c2f-a680-7744eb685177@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <310391e8-fdf2-4c2f-a680-7744eb685177@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 08:18:49PM +0000, Mark Brown wrote:
> On Mon, Aug 28, 2023 at 05:13:12PM -0400, Nícolas F. R. A. Prado wrote:
> > Introduce a new kselftest to detect devices that were declared in the
> > Devicetree, and are expected to be probed by a driver, but weren't.
> 
> I've been running this in my personal CI for a little while now and I'm
> finding it's pretty marginal for the 45 second default timeout in
> kselftest on some platforms, especially BeagleBone Black though it's not
> just that.  BBB is both slow and has a comprehensive DT which won't help
> matters, there's 253 devices.
> 
> I'm running it from nfsroot which is going to be part of the problem but
> shouldn't be too bad since we're mainly dealing with proc and sysfs and
> hopefully mostly running cached binaries, I'm also using a serial
> console to get the output which is going to add overhead especially with
> a large number odevices with length names.  I'm not sure what the best
> solution is here - a quick glance at the code doesn't ring any alarm
> bells for me, this may just be a reasonable runtime for the test.

Thanks for reporting this. I've experimented a bit and was able to find an
effective optimization and CC'ed it to you [1]. Hopefully it is as effective for
your board and setup as it is for mine. Let me know there.

[1] https://lore.kernel.org/all/20231208133955.483851-1-nfraprado@collabora.com

Thanks,
Nícolas
