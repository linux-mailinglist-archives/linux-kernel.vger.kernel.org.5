Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DED813A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjLNS6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNS6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:58:01 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DF510F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:58:07 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-42588e94019so7835221cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1702580286; x=1703185086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbRUvh91lczsHsuPwuxCeC//+oO/v5EJyyqmBzZyIng=;
        b=EUXMasxe9AhFo//EOPmkkuBdjVHTmrpDWnlEXhkGPn0JAfvvB69r6GuYSCINGRghez
         MmDw7wEUuLIXegti5KZdN5sDouIKuugip9ND93AMUh3JLaDO23LZ4gDyMweCyGHKs+An
         lM73TbK+lRRb0X+JM6RVlnZ11IwarDU8EahDM2vYJmIaLQpHBUNU4tffaP0dWFdJCAix
         yeFJSQ5dwCkEyARpEScOxliZRpsBf49xEPbZwqAPUg4RF1eoYl6vjuUupvY7oTUSgSxI
         pRpeAw9ztgfYXYVJ8r4lNd+sDyxzWIqfLHioOMVKWjRxwMUWh0E9iTNBa7PH1+/+VPHI
         9eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702580286; x=1703185086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbRUvh91lczsHsuPwuxCeC//+oO/v5EJyyqmBzZyIng=;
        b=HJ2tsrJ/vKfI//LpRf/MdO14CkZ7r3oKu5kQC+zBbX3xQ/LiT0FPNYnAw1LcymKlQP
         Jyf+BIGe0vzv6wxDyzUp3IAjWgvtGAXz0JvmaICEkVpxwle0UelzjC3B3jG4M5sEfpON
         EcAQXyxGJK5+95GIxkJq61kNUWK0ax9zM8ujFNO6SgzBL8R9LWdVYZS2kobcgFBG22W3
         ZNi049rgxkdp1xEDHIQvYszUyzXEtw1crERxNUa98NCbTQBeQQN1kSNmHbk1lTwi/3LL
         mjDnAY6XmktvAJrj/Xv4434w0843j+uH9PkC0OMAVunJPkDc13r274RvQ7F9roMEjPnT
         lt5A==
X-Gm-Message-State: AOJu0YzE1L4B/YpsmRLhmS1RrlsS2updbJYCmGd4iA+2e9KB+GhdTeZ2
        wgEcxmBc7E/hIAXNjNdidrBvIeS8XC1YEZg4tdAZ6Qi4y05mmVsxBsA=
X-Google-Smtp-Source: AGHT+IHA88EdWJi6YEaUjD/G5Alic42eMo76cOAWFc0QtX1OeP9Hoaw7Y53/0yZMK7MTS4ytkjNfaQ4yEVSKsvmYBtg=
X-Received: by 2002:ac8:5792:0:b0:425:8b1b:a286 with SMTP id
 v18-20020ac85792000000b004258b1ba286mr18152227qta.39.1702580286617; Thu, 14
 Dec 2023 10:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com> <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com>
In-Reply-To: <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 14 Dec 2023 13:57:30 -0500
Message-ID: <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
Subject: Re: [PATCH] vmstat: don't auto expand the sysfs files
To:     David Rientjes <rientjes@google.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for taking a look at this patch, my replies below.

On Thu, Dec 14, 2023 at 12:52=E2=80=AFPM David Rientjes <rientjes@google.co=
m> wrote:
>
> On Mon, 11 Dec 2023, Pasha Tatashin wrote:
>
> > Whenever a new fields are added one of the following: node_stat_item
> > numa_stat_item zone_stat_item, the /sys/devices/system/node/nodeX/vmsta=
t
> > files are auto expanded.
> >
> > This is a problem, as sysfs files should be only one value per file.
>
> Does this patch address the one-value-per-file issue?  (I think that ship
> has sailed for vmstat.)

That ship has sailed for vmstat, this patch addresses what was asked
by GregKH: not to add new values to vmstat, as not to make the
existing problem even worse. The sysfs file system has a one page
limit per file. The developers will decide how to export the new items
added to node_stat, numa_stat, zone_stat individually. Each new item
can be exported in its own files, and must have its own documentation
about interface stability, value meaning, and expectations when the
stat file is absent.

> /sys/devices/system/node/nodeX/vmstat has been documented as a stable ABI
> in Linux for 13 years.
>
> That said, the contents of the file has not been documented so I assume
> it's "whatever stats make sense for the current implementation of the
> Linux VM".
>
> > Also, once a field is exported via vmstat it is hard to remove it as
> > there could be user applications that rely on this field. This is why
> > we still cary "nr_unstable 0" in /proc/vmstat that is not used.
> >
>
> Implementations change over time, so this would be expected.
>
> I'm assuming, but perhaps incorrectly, that userspace won't crash if
> nr_unstable just don't appear anymore.  That whoever is using it would
> just assume that it's zero if it doesn't appear.
>
> So I think we need to answer the question of: are the *contents* of files
> like vmstat that are heavily dependent on implementation level details
> really part of a stable ABI that people can expect will carry on forever?

I agree, but that is outside of the scope of this patch. The intent of
this patch is to keep the existing interfaces, and only prevents
future auto expansion of vmstat files. In the future, we work on
documenting the existing vmstat interfaces, and perhaps cleaning-up
them when possible.

> > Also, since vmstat is auto-expanded the fields are not documented, so
> > users do not know whether they are counted in bytes/kilobytes/pages,
> > and the exact meaning of these fields.
> >
>
> I think that's actually intended since there can also be ones that are
> event counters.  I don't think any fields in vmstat are intended to be
> long-term sacred stable ABIs.

Right, but we already carry fields i.e nr_unstable that are hardcoded,
but were removed from the kernel otherwise.

Thank you,
Pasha
