Return-Path: <linux-kernel+bounces-128127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A577289567F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC863B22659
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8488626E;
	Tue,  2 Apr 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBR5Mh3l"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55E8625B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067829; cv=none; b=KUbjLxUlCgatF1sasve0cn7/EVDhl2jTzFSog3dWNfx5VsMbE4JiZLPhfQPdpws3ZHqeO4XnkXEg6aUaGlY0rlHboTjGQRJXX/Poh/qKrxM5k/wrifMBzQacanOxGa4BBgiWHL7mkTzyXywrXVsii6+9/sFZRkO596umuLGkMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067829; c=relaxed/simple;
	bh=fdvvxMRiUVtu4tInoCST4bHfg7tuF05+ROWiAC7thbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xnwbu6D0dr9UZX9F6HiZY4mjnZ1RTV/J+0YZVU2nukCYkD0y9Ne5R0GTL+WIah5+74dZF8/i/yZw9q0QdRIj+MZHlNExGOw+f4Jv0c0ukojrWl88H77HJnwe4lLiaolaH4iymMk9rgLaoRqGC2somhk9O03uLns7JIw2qwL0RFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBR5Mh3l; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d476d7972aso75521191fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712067825; x=1712672625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgJqRt3TsVpHWSIpSeQO37LB+pyModJnVn2ogzISouE=;
        b=NBR5Mh3lUMvUD4uj1Xwk3hK6r6p8MzmUF96WfiMVyaTTprQ6eOoGQUy2Qp29IdrLLl
         0E9FQMz5nQVHOkIkWd68M51bS6MmFPHIw4Vd7nXDBSB2u+It/Q/t2LV8pvlOYh33R1We
         VxOemCeB15WvW7g0GyUtCa7JywFSJ4XIx+MnK4ZcDhtyYnnjdjW8upp0ay8JugBL5wTn
         0Ou32uO1TNNMW0z35nTUmsHjrUKEiBxtASa6oE1PoFWmSY1uPb3q6FfyBDH27TYjDO1b
         Bk6IYOWSl69c9a/JmbkYsd+hU6XQCrSfcJWiaidjGrqL0NnChYHnrgru0rvYUKNYZkIE
         7wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712067825; x=1712672625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgJqRt3TsVpHWSIpSeQO37LB+pyModJnVn2ogzISouE=;
        b=v+zhivfFoXW2zFmslja+KBZ9QOHZVrGs5k99b4saqWN5wXSQVgK6INw6M4W8glXrUW
         clgX9TNCY+o3Qli2w59UF7b9w9ow/BSB0kd70ts+lXhi5tj0AoZMwydYBHKrK8Wxlyye
         8VJTQh2WdHo1gLORTGTm00I5bUFYP7AsFRqzA43b/aE+3G5rfJ0vZx+TbQ9PUHqrbYMB
         vd7fbiUf46ZLG3+5DOcjWWQwtSUU5Ehw+f6ralVddkTgRB5fuuCyE/20luwnKDcUx+8G
         3abrKoqsFnqlwg0a+FWjxfhIduvSu9y4Jf0dWyKNqrpCuQakkIU93Ny3bRAii+v/qFOD
         1Glw==
X-Forwarded-Encrypted: i=1; AJvYcCWHXZXeNSbcaWVbpKxaJ6honmnvnI526Qs+DD/yc48BRq+/T/2NsN7XpIqHLh9dEcwgQHkNNXr2tLlTCEoM2oGn80U4jOyDn7PiY/Nn
X-Gm-Message-State: AOJu0YxHypovzAns2t4jaa5lmG0Wb+8fgiUrUwz3YcnCgdqG4M3lTXqn
	3VZ/U/mC6QCc4AcOTnjMohbU25yoMxmvdfoTFfaHabyyDnf+tOo2j/OVzVWSmysW8Drjsxie2Ic
	0JvvAeHVJn+jJXPut2HCGi0sFrQ4DmsosKc+Dmw==
X-Google-Smtp-Source: AGHT+IG/G8Z0PqvnCWP/jltJ6TyZ4Zvc6O/H5tBwxhHxT81LMQPHAnYZYFzuLtjTF9MVvIpB/9P9hN/Ud8PcV0sKnEQ=
X-Received: by 2002:a2e:8699:0:b0:2d4:6815:fc6f with SMTP id
 l25-20020a2e8699000000b002d46815fc6fmr7584552lji.30.1712067825431; Tue, 02
 Apr 2024 07:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
 <20240321084614.45253-3-angelogioacchino.delregno@collabora.com>
 <ZfxRyMyUqyqtXy8n@p14s> <9ef4e974-740e-4698-bb38-f236521a425c@collabora.com>
 <ZgWA/E46i/CaoM74@p14s> <b6ed8710-1608-4343-8a58-5f8e0e16d10d@collabora.com>
In-Reply-To: <b6ed8710-1608-4343-8a58-5f8e0e16d10d@collabora.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 2 Apr 2024 08:23:34 -0600
Message-ID: <CANLsYkyu69Pwv094XGfVomuu1Oixw3vxr42q6WOE4F3snATygw@mail.gmail.com>
Subject: Re: [PATCH 2/2] remoteproc: mediatek: Don't parse extraneous subnodes
 for multi-core
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: andersson@kernel.org, matthias.bgg@gmail.com, tzungbi@kernel.org, 
	tinghan.shen@mediatek.com, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, wenst@chromium.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 03:56, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 28/03/24 15:38, Mathieu Poirier ha scritto:
> > On Wed, Mar 27, 2024 at 01:49:58PM +0100, AngeloGioacchino Del Regno wrote:
> >> Il 21/03/24 16:27, Mathieu Poirier ha scritto:
> >>> On Thu, Mar 21, 2024 at 09:46:14AM +0100, AngeloGioacchino Del Regno wrote:
> >>>> When probing multi-core SCP, this driver is parsing all sub-nodes of
> >>>> the scp-cluster node, but one of those could be not an actual SCP core
> >>>> and that would make the entire SCP cluster to fail probing for no good
> >>>> reason.
> >>>>
> >>>> To fix that, in scp_add_multi_core() treat a subnode as a SCP Core by
> >>>> parsing only available subnodes having compatible "mediatek,scp-core".
> >>>>
> >>>> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
> >>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >>>> ---
> >>>>    drivers/remoteproc/mtk_scp.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> >>>> index 67518291a8ad..fbe1c232dae7 100644
> >>>> --- a/drivers/remoteproc/mtk_scp.c
> >>>> +++ b/drivers/remoteproc/mtk_scp.c
> >>>> @@ -1096,6 +1096,9 @@ static int scp_add_multi_core(struct platform_device *pdev,
> >>>>            cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> >>>>            for_each_available_child_of_node(np, child) {
> >>>> +          if (!of_device_is_compatible(child, "mediatek,scp-core"))
> >>>> +                  continue;
> >>>> +
> >>>
> >>> Interesting - what else gets stashed under the remote processor node?  I don't
> >>> see anything specified in the bindings.
> >>>
> >>
> >> Sorry for the late reply - well, in this precise moment in time, upstream,
> >> nothing yet.
> >>
> >> I have noticed this while debugging some lockups and wanted to move the scp_adsp
> >> clock controller node as child of the SCP node (as some of those clocks are located
> >> *into the SCP's CFG register space*, and it's correct for that to be a child as one
> >> of those do depend on the SCP being up - and I'll spare you the rest) and noticed
> >> the unexpected behavior, as the SCP driver was treating those as an SCP core.
> >>
> >> There was no kernel panic, but the SCP would fail probing.
> >>
> >> This is anyway a missed requirement ... for platforms that want *both* two SCP
> >> cores *and* the AudioDSP, as that'd at least be two nodes with the same iostart
> >> (scp@1072000, clock-controller@1072000), other than the reasons I explained some
> >> lines back.
> >>
> >> ...and that's why this commit was sent :-)
> >>
> >
> > Please update the bindings with the extra clock requirement in your next
> > revision.
> >
>
> Ok.
>
> Can you please take only patch 1/2 of this series so that I can delay this one
> for a bit? I don't have time to work on that exactly right now.
>

It was added to rproc-next last week.

> Thanks,
> Angelo
>
>

