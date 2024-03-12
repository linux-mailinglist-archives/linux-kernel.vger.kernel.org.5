Return-Path: <linux-kernel+bounces-99716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565E878C28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AF4B2108B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EDE6FD5;
	Tue, 12 Mar 2024 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eB+KKJnG"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFE6FA8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205996; cv=none; b=bTs9tUA3Js2tpy/4CXAaqs1OcPZXSEw3y8g0c0lYP7xocgiJ6La/QpA0GPvNcmWL4rwv5VSOiBTF5knhgtmKigiyzpJlIZ4XzN7wNjvN3xbBZdxaq/LOUDB9zsr+9fnQY5sHftadaoX4SQ4XXaeKP4jPEq9qE9gXLfDsl0Cs5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205996; c=relaxed/simple;
	bh=OoTfBiXWRGI+caRKGfOwBQ7X4jH3qbOdB8+DW++9Ti4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeE3l8ZdZ325VHxPMaZ6DH4O8NoYuMvdC44lZEMci0BzgHUw1GHpBOBkAtHI8bQVwehczrcpu5QBpa6fA09/KtopIEhNu4suKbKNOXVLGBdPJOqOR2U0QYYIHKmifH8Mpov2uxy4hWPeXFoHlEThixvcqFk9CGgmPkIoEdzMwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eB+KKJnG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so5934001a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710205992; x=1710810792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ffcfxp86MIw0q9t4PzeGv7I+ngeEtHYjmW7Mt61FKs8=;
        b=eB+KKJnG1fj7ry/MA9wgLbRjat+rzW9/K6OrU0mzHsVFOm3xuvT8hS8xpk2wLLjMaR
         xiuYcqOopBh1nUpF/FjEekEiQ2NPfyvVOsVNu+CthLh/gq9Ef364xQTuN2FLWvBtf0Gi
         F7bJWp2cjCGL5mSa4Qv7JZ0PTsqA58UhUcuI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710205992; x=1710810792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffcfxp86MIw0q9t4PzeGv7I+ngeEtHYjmW7Mt61FKs8=;
        b=LtqK1uK3QFBZfSo4oCTI3Xg+Msz1Ft6sBmQGnWtYjCdAcJBNgj5HvyoYzMPhoi+pGS
         HuNFusz5t9RgrAGNmy6Eae60/0VBjvA/gOEfgzlUxqBPI0rTvYKtUYM0JOH8ztVDrMdo
         lNl47zCdYAxh3Z2zaJ5q60xgSBkzUfR1S9BS9YJwu5uzQeInpi4/qBYg9/Lt098iH15z
         CFlSNHMUGjw66JTD2XvroDnjsdgbiupKa1BA/X26TiWWNklxemxzHED/LfEtCa/3cb5s
         9lC6sJ+WjSK4za+IbRsyOzoVmePrHjqgYna+M3jGOS1Cckye1RqDiZr/UVc7pU5btCmW
         u8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3P2nGfVfERB5wlrp1kl1LC14lSURIXqCh0rDsqf2NGQODW1dE7Jyl2aAixI1YS9pRMJk7OJK2IkVLxS1NHSj9kad7FNTe94yJ0JDR
X-Gm-Message-State: AOJu0YzVlGXYq9iN/u2HB74UBsyl/Pv82ED7Rv4WYp6phRk84s1Bh5jJ
	HOOiyIXXCl/8apzVyiXlX36LOIDii25at+S8a9L8KSO9oP2rShMFsINeb1DC2A1ei+4hARe0QLF
	mecUJ1w==
X-Google-Smtp-Source: AGHT+IGXFHsXhR1SgChWmqgUavSxAIQ84qA0dYBX4kl7y22dXJNRhbZCXl6OkXRTip5higHy5iSgGw==
X-Received: by 2002:a17:907:7284:b0:a46:2b6a:d7aa with SMTP id dt4-20020a170907728400b00a462b6ad7aamr3078621ejc.41.1710205992374;
        Mon, 11 Mar 2024 18:13:12 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b00a44a859fd9dsm3390846ejb.174.2024.03.11.18.13.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:13:11 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a462b068416so186667766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnuXKZx/qoIAQnQQtuVPIOChOI0/rQ26xxp+lhsrUzUJat54owebbYfscXw0LmXfgdYOBTZy0l3Kq8mNCJljCoTGOX+rwspu3iKhPY
X-Received: by 2002:a17:907:a801:b0:a45:94bf:18e6 with SMTP id
 vo1-20020a170907a80100b00a4594bf18e6mr6438267ejc.73.1710205991317; Mon, 11
 Mar 2024 18:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
In-Reply-To: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 18:12:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
Message-ID: <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for v6.9
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, 
	linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 08:57, Borislav Petkov <bp@alien8.de> wrote:
>
> -       return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
> +       return topology_amd_node_id(err->cpu) % topology_amd_nodes_per_pkg();

Ho humm. Lookie here:

    static inline unsigned int topology_amd_nodes_per_pkg(void)
    { return 0; };

that's the UP case.

Yeah, I'm assuming nobody tests this for UP, but it's clearly wrong to
potentially do that modulus by zero.

So I made the merge also change that UP case of
topology_amd_nodes_per_pkg() to return 1.

Because dammit, not only is a mod-by-zero wrong, a UP system most
definitely has one node per package, not zero.

               Linus

