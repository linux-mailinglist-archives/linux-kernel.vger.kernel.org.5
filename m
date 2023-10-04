Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE707B8DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjJDUJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJDUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:09:39 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60391BF;
        Wed,  4 Oct 2023 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NVCbCcKpAlwu23BYOlruPYffWTQeMxOp6lEM7B0gGYU=; b=AkB6IRPVgNaKj2xb/8d1n3NE21
        4DtE83V/QE2UYv2uUNkII0R0JJZcbcRnzbdtgMo5OI/7Yb5TRpzV+vpcTD/Eh9prGrX/+xyA8Xtb3
        IBIN4E+YCDecXpqDnGhrXfo5nh4YOMfstBlNrBlrywZbM0BnCvpR4/9XTACO6BhLfV7aONJAsu25i
        Yf1xhiZz88NYAUlXsqZ/dP2kaRpGEj1eWOumOcQa/gxmbX8+cw2fzeXWvZkGNmZqdgQWSFbEbJMJF
        6eH/CK2ZpJT+yff9D4hd2w/ViGB7Diby0ZOt+8WrvWF2zmlRZ3vq51QfBJe6nqAYV+9CqWI50/X/l
        5ABrmhzg==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qo8BM-00FpAZ-0X;
        Wed, 04 Oct 2023 20:09:20 +0000
Date:   Wed, 4 Oct 2023 13:09:16 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/3] Documentation: netconsole: add support for cmdline
 targets
Message-ID: <ZR3GbHOyxx+J4FUn@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20231002155349.2032826-1-leitao@debian.org>
 <20231002155349.2032826-4-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002155349.2032826-4-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:53:49AM -0700, Breno Leitao wrote:
> @@ -155,6 +152,24 @@ You can also update the local interface dynamically. This is especially
>  useful if you want to use interfaces that have newly come up (and may not
>  have existed when netconsole was loaded / initialized).
>  
> +You can control and modify the targets defined at boot time (or module load
> +time) by creating special targets names. These special targets are named
> +`cmdline` concatenated to an integer, example: `cmdline0`.

The special names are already "created", so perhaps it's a little
clearer to say something like:

```
+Netconsole targets defined at boot time (or module load time) with the
+`netconsole=` param are assigned the name `cmdline<index>`.  For
+example, the first target in the parameter is named `cmdline0`.  You
+can control and modify these targets by creating configfs directories
+with the matching name.
```

> +
> +Let's suppose you have two netconsole targets defined at boot time::
> +
> + netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc;4444@10.0.0.1/eth1,9353@10.0.0.3/12:34:56:78:9a:bc
> +
> +You can modify these targets in runtime by creating the following targets::
> +
> + mkdir cmdline0
> + cat cmdline0/remote_ip
> + 10.0.0.2
> +
> + mkdir cmdline1
> + cat cmdline1/remote_ip
> + 10.0.0.3
> +

And of course keep the examples as you've described them.

Thanks,
Joel

-- 

Life's Little Instruction Book #337

	"Reread your favorite book."

			http://www.jlbec.org/
			jlbec@evilplan.org
