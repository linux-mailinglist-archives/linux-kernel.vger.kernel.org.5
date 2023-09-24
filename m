Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FFE7ACB78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjIXSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIXSrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:47:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC9CE;
        Sun, 24 Sep 2023 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=BKloag/y3wObRwoHJ5YrsbKpoVh/LwWhJ9+J5Kji/kA=; b=Ep28kp7txgrei0cOh+31XEsElD
        Uzwgq+koccxwXa1ObQO23d5sYB4Mph+b1oeOUNSb2h6RnIjDZIzDvvd7uPk7xDuudb8zVlt6bKMq1
        DPKPtF06yTZoz5t7kgbR8zQJ8+eOjjD5zph9fkQM2VCSsisTEhUYdZasvccGWPNS9A6CZfaqZzqN/
        luTLjZ5FjgSdAPDsGzlMlGlod+KZZmZcqd0gVrqdQVT8rGiFU9j2rEFZhbW0zbiey7J12WBgUZMFD
        dEJRrFzEaWxHlmawN2s+VcEbRk7ce1rfJdw+FnlbMwiEFxa3IWyD2tfa1VWTl//5gKhkVFhGeMGU3
        krnWPfrQ==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkU8r-00Cbfy-1j;
        Sun, 24 Sep 2023 18:47:41 +0000
Message-ID: <5fd1b5cd-ea6c-44a1-9cb5-8f692d32ec99@infradead.org>
Date:   Sun, 24 Sep 2023 11:47:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Fix Sphinx 8 warning caused by paths represented
 with strings
Content-Language: en-US
To:     Claudio Cambra <developer@claudiocambra.com>,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230924184057.91861-1-developer@claudiocambra.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230924184057.91861-1-developer@claudiocambra.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/24/23 11:40, Claudio Cambra wrote:
> Running "make htmldocs" generates several lines of this warning:
> 
> Documentation/sphinx/kerneldoc.py:141: RemovedInSphinx80Warning: Sphinx 8 will drop support for representing paths as strings. Use "pathlib.Path" or "os.fspath" instead.
>   doc = (env.srcdir + "/" + env.docname + ":" + str(self.lineno))
> 
> Making "doc" an fspath type and creating a new variable with the
> appended colon and lineno fixes this warning.
> 
> Signed-off-by: Claudio Cambra <developer@claudiocambra.com>
> ---
>  Documentation/sphinx/kerneldoc.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index 9395892c7ba3..e2c835e10dba 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -138,7 +138,8 @@ class KernelDocDirective(Directive):
>                      lineoffset = int(match.group(1)) - 1
>                      # we must eat our comments since the upset the markup
>                  else:
> -                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
> +                    doc = os.path.join(env.srcdir, env.docname)
> +                    doc_with_line = (doc + ":" + str(self.lineno))
>                      result.append(line, doc + ": " + filename, lineoffset)
>                      lineoffset += 1
>  

This patch should be sent to the linux-doc@vger.kernel.org mailing list,
with the Documentation maintainer copied on the patch.

We also have this similar patch to consider:
  https://lore.kernel.org/linux-doc/20230910040811.53046-1-erer1243@gmail.com/

Thanks.
-- 
~Randy
