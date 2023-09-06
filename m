Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394E4796DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbjIFXe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbjIFXe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:34:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B1F183
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:34:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so67776466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694043292; x=1694648092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qp8O0CMBmeOIHtiFssMdoCJLtqwjaGXGbc+VERwFhw0=;
        b=V/N519qu5JazzkeIdURw3oC3QCLO89U+78Gj0dcE68QhkUt5J/oK+MgsRLdUSgur9h
         gRqNckES2b/vaaGdkFH4Q3nirBMILsS86OhpQKBLKwNsehdDcdzpwiR8K+Jo7VscWl3S
         /XP9fFTiOvy9MeAfWhN1rWAgv8v24n7yHvQ/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694043292; x=1694648092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp8O0CMBmeOIHtiFssMdoCJLtqwjaGXGbc+VERwFhw0=;
        b=dunBaeFUo6YcXcKsTTwqkTQhcx4pPdWrllz8bIz1Nlot98sYLu/KXRIap1QetROB71
         fm/KKWOGZMqU9OGT2TK980/1djk80ZE4OJ0/XV0013By/euOChShWPerAWhQl2qfuuuJ
         7SLTOLkfjuksOC3iPpsg/cMy6EZtGe2LWrHRJUwyxdpjttSJBslRGywmioBuD0cOBGpI
         B7PLQeDuzD4qIpU3qrwn5niaBKPLWwRln8F10aS50218VETJANLaohAUpR43L0wX9/u4
         ztskI7jjZ3brPTppWm0zAPN1Y6nXzFVYw1WJY3zKiBK5z4ja6Y8Bha9eeKTdOzR7JJEG
         irtw==
X-Gm-Message-State: AOJu0YzISSVbaabysZ8eDIrljakqwu7FU5sYyWVCbP1us7YXtb0H8ESy
        G6/ljr0V+dWbaYfGg1nJlG4ZFfgt2KJJV/3fUh/FEXp+
X-Google-Smtp-Source: AGHT+IG8XwZ/WMAsFd9d/zYpTJMP4oQjGdFMVM/aT1T7gv3JQu8K95ke+xuwqBfheRj8P+DLhzSpXw==
X-Received: by 2002:a17:906:6a07:b0:9a5:c38d:6b75 with SMTP id qw7-20020a1709066a0700b009a5c38d6b75mr1470266ejc.15.1694043291868;
        Wed, 06 Sep 2023 16:34:51 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b00982cfe1fe5dsm9623575ejb.65.2023.09.06.16.34.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 16:34:50 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so638067a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:34:49 -0700 (PDT)
X-Received: by 2002:a05:6402:4405:b0:52e:83d0:203e with SMTP id
 y5-20020a056402440500b0052e83d0203emr1287353eda.10.1694043289719; Wed, 06 Sep
 2023 16:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
 <ZPj1WuwKKnvVEZnl@kernel.org> <20230906231354.GX14420@twin.jikos.cz>
In-Reply-To: <20230906231354.GX14420@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Sep 2023 16:34:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+RRhqgmpNN=WMz-4kkkcyNF0-a6NpRvxH9DjSTy9Ccg@mail.gmail.com>
Message-ID: <CAHk-=wh+RRhqgmpNN=WMz-4kkkcyNF0-a6NpRvxH9DjSTy9Ccg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     dsterba@suse.cz
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sept 2023 at 16:20, David Sterba <dsterba@suse.cz> wrote:
>
>     I think I've always seen an int for enums, unless it was
> explicitly narrowed in the structure (:8) or by __packed attribute in
> the enum definition.

'int' is definitely the default (and traditional) behavior.

But exactly because enums can act very differently depending on
compiler options (and some of those may have different defaults on
different architectures), we should never ever have a bare 'enum' as
part of a structure in any UAPI.

In fact, having an enum as a bitfield is much better for that case.

Doing a quick grep shows that sadly people haven't realized that.

Now: using -fshort-enum can break a _lot_ of libraries exactly for
this kind of reason, so the kernel isn't unusual, and I don't know of
anybody who actually uses -fshort-enum. I'm mentioning -fshort-enum
not because it's likely to be used, but mainly because it's an easy
way to show some issues.

You can get very similar issues by just having unusual enum values.  Doing

   enum mynum { val = 0x80000000 };

does something special too.

I leave it to the reader to figure out, but as a hint it's basically
exactly the same issue as I was trying to show with my crazy
-fshort-enum example.

              Linus
