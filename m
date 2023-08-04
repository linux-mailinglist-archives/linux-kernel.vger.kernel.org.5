Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1E770326
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjHDObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjHDOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:31:28 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F7749D4;
        Fri,  4 Aug 2023 07:31:26 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56ced49d51aso1464387eaf.1;
        Fri, 04 Aug 2023 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691159486; x=1691764286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYpBxe18O9ebx8igO3q7NyRd87YtCT0rdfN3zvPApgI=;
        b=oijhw6yEfQ/Gr63RM7nAd84ZnPjQT+kXrBumKbnAHcZ4rHRReLEa3+OYzfOI7ES2+E
         wepTnpwSnOATN4OWihc3m/kXP+2Uaz636mAO83udM/+B1nJXj3FJ+YGGSfdbvmeKvo9k
         S6JQkEs052p8EV+sJRgCRme6glKP0tiuCJLAYITu7JzxSmRB+i5/+ma1dgrAikK5C3aU
         l/z0GakzVcs4b3FcdPnxVuQksom/v49f2EaY33QX2Md4YKqZM3GbNHOURg+TcgL0Hjp/
         6bZyr4f+EHt1CSnLLHPaViy8eMwP8OXjjzfwK5IMH/cwAIc59gzvViZVyiX9XTiKQd/V
         TdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159486; x=1691764286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYpBxe18O9ebx8igO3q7NyRd87YtCT0rdfN3zvPApgI=;
        b=WlwFI0JEVP6gN3pfaIuViKCAaukVDiGClpACGNs8934MYnXSuxrGsQvSit+A/jZOJ5
         XcIUNXnpHgrZtzrzKjczgz8hjrOZiRAw7i5GB66LSI2F0rcdsnalX5JjEPYssk4snrrA
         xiVRosjo5cM8CQAeXEuDkOMHUAujNeOqb1hW0xJDBuNdoqqddjMWzMklGJVnquRvOT0r
         Hml6YEP0jqhFCHj5/6rE++g6jhLM7fAFVAmlIJcAndAFT26DtLepl9tgI9ICDJKR7Bj9
         f5nutuvuG/ZtUy/f0r9hwLXZRt8sfUjl/g9XMFVbb+VTYAIUHHC6mXroUECdubfJ5iMF
         uUVA==
X-Gm-Message-State: AOJu0Ywno39+e3MPWbSD8D8lwjPD/tidRsfN8JCP6MVOvuLNFcHTMJPB
        M4aXl5tkkutHh10Xyi+M1a+qvu4kj/RRjs07yXc=
X-Google-Smtp-Source: AGHT+IESHPgcOp8j8ide4iiYmR9cnMaZoujqhuQMLW3XIceF7oxnQJ75jegw8XXhWyQ1VXTyTa35EFzqtZUoEOsBi0I=
X-Received: by 2002:a4a:ce98:0:b0:56c:d045:2aba with SMTP id
 f24-20020a4ace98000000b0056cd0452abamr1782436oos.4.1691159485904; Fri, 04 Aug
 2023 07:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230628153211.52988-1-andriy.shevchenko@linux.intel.com>
 <20230628153211.52988-3-andriy.shevchenko@linux.intel.com> <2023080456-ride-unrobed-b738@gregkh>
In-Reply-To: <2023080456-ride-unrobed-b738@gregkh>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Aug 2023 17:30:49 +0300
Message-ID: <CAHp75Vcb-uTh0r4YKACAcBwePHjs8Rn0R44NN+oyz11tbCG0Sw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] driver core: Replace kstrdup() + strreplace() with kstrdup_and_replace()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 5:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 28, 2023 at 06:32:09PM +0300, Andy Shevchenko wrote:
> > Replace open coded functionalify of kstrdup_and_replace() with a call.

Oh, here is a typo.

...

> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you, Greg!

Stephen, can you take the series now (okay, I think I need to send a
new version with all tags and typos fixed)?

--=20
With Best Regards,
Andy Shevchenko
