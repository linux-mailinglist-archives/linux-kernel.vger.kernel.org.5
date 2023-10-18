Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB107CEBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJRXXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJRXXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:23:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D34116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:23:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so1157005566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697671390; x=1698276190; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aPhK2v2olpWwvbqgYWUIgHGAZuQtwrggUX5EKpXeoYU=;
        b=ZXyMgwn8X+KBBEpAfbKI9KKaQecfkscFkKItp5ifFxAHnf7py1cy+x2lOqd9dXGgE/
         Ezb/dZ9NHKOGoLcitGYlz+IF3PhpnrZmaqBOWqBC+Rf4Q93ybQyGXzXr6dLJr3DtowII
         I0RVQSADTSSeEFBogzLpHA2FbcaJcxdiLKFGLPx9RRaqQzToFwluY9YcXtPxSt0RLFNn
         /Q6IHSuRwDLiKIsyuhrrTgkHkxQgLT8cIc5HFUKYSiHKe16ZuWWdGfEXzbRtW2NXhFjb
         c7lzSdybRpT6w3MZOUnSgsSJvRAvxC6BXBAp3ohBSgqprGgf7KoAtrNdz6mTRlIPmH4a
         DvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671390; x=1698276190;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPhK2v2olpWwvbqgYWUIgHGAZuQtwrggUX5EKpXeoYU=;
        b=VRbvj/oOju80KuSTuqzkf68Wj3tq64Y0FTZUX73Ll44pJtBXFsoXWyQu60nUf3Oeo7
         eEDxcH8eSaiNTgD9aYiwHqknkSoDI+bNg7kPqWoWZNfrqqLr8+yFaqfxVaVBH/9ML6TK
         V3yDcrZ1SfCh58/OlsA7Fp8rWM9/bWfvclEG7xpnOUsHsU1n6zn9St41X1Tt4m91Jj3A
         TvVRibTh3ge5JONzUfLpihuRN4mHVcTj+DCTmTihuoLrhkQkiZbFIrmpbscxC75k5Vdf
         XRr0fkIH7dkcfTFAdSlS758QFyiC2ib30+AdRbBMkAXlTlfXJ9eX6PFvzbJXF6zRFwN7
         z7ag==
X-Gm-Message-State: AOJu0YzUsSYgm3vdwIY2MhofWCIurVrPOb39fwFiZhqb51cp5K2EJnb1
        QHJFlcZui3cDfS/QL526vYHC3oV8Bc06FoURThWcVMMbtpw=
X-Google-Smtp-Source: AGHT+IGGQBT86Li160jgb5V5AcIDWLLxJMEVwnMdZWwlzBrnlfAeLgwK5elL86jbzD9sTqBiC3k2IAcoYdqpjNr8Vcg=
X-Received: by 2002:a17:907:318c:b0:9b0:552c:b36c with SMTP id
 xe12-20020a170907318c00b009b0552cb36cmr628157ejb.21.1697671389635; Wed, 18
 Oct 2023 16:23:09 -0700 (PDT)
MIME-Version: 1.0
From:   James Dutton <james.dutton@gmail.com>
Date:   Thu, 19 Oct 2023 00:22:33 +0100
Message-ID: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
Subject: Is strncpy really less secure than strscpy ?
To:     LKML Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is strncpy really less secure than strscpy ?

If one uses strncpy and thus put a limit on the buffer size during the
copy, it is safe. There are no writes outside of the buffer.
If one uses strscpy and thus put a limit on the buffer size during the
copy, it is safe. There are no writes outside of the buffer.
But, one can fit more characters in strncpy than strscpy because
strscpy enforces the final \0 on the end.
One could argue that strncpy is better because it might save the space
of one char at the end of a string array.
There are cases where strncpy might be unsafe. For example copying
between arrays of different sizes, and that is a case where strscpy
might be safer, but strncpy can be made safe if one ensures that the
size used in strncpy is the smallest of the two different array sizes.

If one blindly replaces strncpy with strscpy across all uses, one
could unintentionally be truncating the results and introduce new
bugs.

The real insecurity surely comes when one tries to use the string.
For example:

#include <stdio.h>
#include <string.h>

int main() {
        char a[10] = "HelloThere";
        char b[10];
        char c[10] = "Overflow";
        strncpy(b, a, 10);
        /* This overflows and so in unsafe */
        printf("a is  %s\n", a);
        /* This overflows and so in unsafe */
        printf("b is  %s\n", b);
        /* This is safe */
        printf("b is  %.*s\n", 10, a);
        /* This is safe */
        printf("b is  %.*s\n", 4, a);
        return 0;
}


So, why isn't the printk format specifier "%.*s" used more instead of
"%s" in the kernel?

Kind Regards

James
