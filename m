Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B087EA547
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjKMVKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKMVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:10:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A77DD5E;
        Mon, 13 Nov 2023 13:10:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32fd7fc9f19so2985653f8f.2;
        Mon, 13 Nov 2023 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699909802; x=1700514602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uu2Fdn1/AhrsLPNFAbQh27UsxWv3qkwNYBB7Mwhj8eU=;
        b=KqeeSEHjI72JDS9kEaK2wzjUWDNJ6iWRSf6yJdTVJCrzkWr48eQrsOL7va4xaFaqOR
         XQkhMmgM8Q17viWIOjviRx8RGK1gs4+gDUS88uLqiO2FcaNsuksnVWNFSpnTYa3VRuqs
         BbvGfsDAhRr57f3jZt9ILN1SiUnTnfltD6JMHUb1LTy2nzzYPhCbGggVujaHSRg++tC3
         0lnO1aJcwF2pR+XGidJcRcFMUkf0PMYMnFZMhf+t8nvhzqHVAOPBnzc6SgFPQofr5ZNE
         eQxSvOUi547b7u7UK/Pa0tbbxE1axfxPci7uncEigavyRYpLovLjuE9SKZK0U5HoKg0/
         t7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699909802; x=1700514602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uu2Fdn1/AhrsLPNFAbQh27UsxWv3qkwNYBB7Mwhj8eU=;
        b=Oo5RAzBwOxRDt/uAPjGg7TtTaW1u1UEfgVrUKLRhjjjHIQ/Fzs+dCmcuHd7WKXE2So
         sM0zcKgYpG6MEPsE6//rogeKDqT/TgfvLzb03/9xNyay2jCMaYCA6J+dxXh1Dwq8d050
         K/fT6XnxssHBGxKW6LyPb8rVZGsOansPssdOK5CqMNqmOLCzsO35sP4td9WBKpchqsXA
         ut0S4scufh9ZpkPkxDXd4kBHuzrRGYlA5nGRlizGu59SI0ltWUWq4sr38oflSjrMLpw9
         7AQAxRbzUFz9uw7r2xuEYEkmFfeHNN9tQVRNtLNkgDphz+DgKKOiqFiQ02b1sxOrg/xD
         AbAw==
X-Gm-Message-State: AOJu0YzIZj2Ovij6zwTHB2a89iijhs4OYGQbmy2dfYUDNSqZKz+OnmB4
        drVBcDtEgCHRP6YD6dpGXxfGwKAw8tFULxTQmTIsiVV/0A==
X-Google-Smtp-Source: AGHT+IHvBvNI4YrxW7uA5gKMQCUOZK9qqY8YrVvnDQGBIbAZyvmQ5t0oDNL035GEhXa0Kbb5abwGve67jWM8NJ4LeEE=
X-Received: by 2002:a5d:5887:0:b0:32f:c750:6ec3 with SMTP id
 n7-20020a5d5887000000b0032fc7506ec3mr4321731wrf.65.1699909801795; Mon, 13 Nov
 2023 13:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20231113182227.698989-1-tomas.mudrunka@gmail.com> <2023111333-duly-mobility-edc7@gregkh>
In-Reply-To: <2023111333-duly-mobility-edc7@gregkh>
From:   =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date:   Mon, 13 Nov 2023 22:09:50 +0100
Message-ID: <CAH2-hcLoz591mduTVPtFd0ZOEzMNSzhU108qqvv-ZWre7+jm9Q@mail.gmail.com>
Subject: Re: [PATCH] /proc/sysrq-trigger: accept multiple keys at once
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 13. 11. 2023 v 19:33 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> What did you just break where people would send a string and only relied
> on the first character being checked?  This might not be ok to do.

It truly might not be ok. But i hope you will not consider me impolite
if i open further discussion. Is this actual use case for some people?
I understand that it might be, but currently i can only think about
this being done by mistake, rather than on purpose... are you aware of
any software actually leveraging this feature?

Please also note that there is really good use case for this. if i do
the REISUB bash loop as suggested, the bash will be killed during E or
I and the rest of emergency procedure will not finish. Therefore i
really think it makes sense to be able to pass whole sysrq batch to
the kernel at once.

In case you are sure that this is a bad idea, i can suggest
alternative approach. only activate the "bulk mode" when first
character is '_' (underscore).
User would then be able to do
echo _reisub > /proc/sysrq-trigger

Would you prefer if i do it this way? In my opinion it does introduce
little unnecessary complexity, to fix something that might arguably
not be actual issue. I mean... we still have /dev/null in case people
need to discard some extra characters. :-)
But if you think it's better to stay on safe side, i think it's viable
option as well...

> Also, no documentation update?

Will fix this one in v2.

> thanks,
>
> greg k-h
