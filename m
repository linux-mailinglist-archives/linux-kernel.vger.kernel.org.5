Return-Path: <linux-kernel+bounces-106052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A987E860
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF73282A51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668D3715E;
	Mon, 18 Mar 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMZaw6oQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ns21CzD8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4A364C0;
	Mon, 18 Mar 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760709; cv=none; b=pmPeod7ZmFa/K+2p8rAxtYq5hmg11H463WssbB4MB09KeGapmdySpW1a98FKohaU+AWdmWxq4aT94WkgR+/bK3E/Xpg5c9a0eTtz/ZUFlgqmIPlJJSousJsVOl5IZuoFRJkddr3aFqXFrpwGoWS0JRP7D73IdOP6k3f3sLON43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760709; c=relaxed/simple;
	bh=mrxJiPMIzd1108cDGaKA2JQTQvRqDxwh+7+B6ymHd2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J5x+1/7ggtDwC/msf14t2MRaYZG+8YFr06XboZxtCzPsMMy1oP3tIiUgiWeTnEm89QD2gK8GCjUFsy4Lwo0vrHsldVEUQFsdU7N0g6JL9VegvgtYKl1F7a3EeSwdCkBmqTFxcArPdJzPxcNeHooZxA3oc3I3qLwWCSG/H1IzGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMZaw6oQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ns21CzD8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710760706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvIggp9l8ynrqFOvlVbqfquG9gIGDPBk0SZBCYKXfbU=;
	b=lMZaw6oQ1fHGFGfKXCbfbhQRu7naS85vR947W3thfkBD4nW96p4X1auZ0a2fcRXnpsApw0
	f+UsUpnhrmvCbwvtaJIvjMEmVL6T9gPBGcPUtZm+q5NQ9cgapVCvmBRpQl7WiiuTT9jIty
	ZCB8vqzv8d7U5eu4EEonzAxX1iKaSdRqMIYx5ldBORa8KwirkFyxJc8fQ5FptnJyzcax/U
	WhuNaT6bxPBVSeDLROBwyarp0PjPfAm8PF0oy+iUkeiMhw1vlcU1Yb3HDp8oIAXbAP/9pD
	FFFJg/fq3N6sg/Pjceqby7CB1jSNBLGUvTZRYh9PXM76nKzBRK8bYqQvBmEcNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710760706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvIggp9l8ynrqFOvlVbqfquG9gIGDPBk0SZBCYKXfbU=;
	b=Ns21CzD8Yfb/RqS9JQPTBOvmfNr2KLQ+6eTddGTLI5Jdh2G94eMwmSkVj9GoMc9QotccU9
	EqE3VMvo5z562IBg==
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Tianyang Zhang
 <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Baoqi Zhang
 <zhangbaoqi@loongson.cn>, Biao Dong <dongbiao@loongson.cn>
Subject: Re: [PATCH V2] irqchip/loongson-pch-pic: Update interrupt
 registration policy
In-Reply-To: <0fda46c7-87e1-41f1-b3f0-ee3d1a4ac601@wanadoo.fr>
References: <20240316082141.26139-1-zhangtianyang@loongson.cn>
 <0fda46c7-87e1-41f1-b3f0-ee3d1a4ac601@wanadoo.fr>
Date: Mon, 18 Mar 2024 12:18:25 +0100
Message-ID: <87wmpziy9q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16 2024 at 15:03, Christophe JAILLET wrote:
> Le 16/03/2024 =C3=A0 09:21, Tianyang Zhang a =C3=A9crit=C2=A0:
>> @@ -171,6 +183,27 @@ static int pch_pic_domain_translate(struct irq_doma=
in *d,
>>   			return -EINVAL;
>>=20=20=20
>>   		*hwirq =3D fwspec->param[0] - priv->gsi_base;
>> +
>> +		raw_spin_lock_irqsave(&priv->pic_lock, flags);
>> +		/* Check pic-table to confirm if the hwirq has been assigned */
>> +		for (i =3D 0; i < priv->inuse; i++) {
>> +			if (priv->table[i] =3D=3D *hwirq) {
>> +				*hwirq =3D i;
>> +				break;
>> +			}
>> +		}
>> +		if (i =3D=3D priv->inuse) {
>> +			/* Assign a new hwirq in pic-table */
>> +			if (priv->inuse >=3D PIC_COUNT) {
>> +				pr_err("pch-pic domain has no free vectors\n");
>> +				raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
>> +				return -EINVAL;
>> +			}
>> +			priv->table[priv->inuse] =3D *hwirq;
>> +			*hwirq =3D priv->inuse++;
>> +		}
>> +		raw_spin_unlock_irqrestore(&priv->pic_lock, flags);
>
> Hi,
>
> not sure if it helps or if this is a hot path, but, IIUC, taking the=20
> lock could be avoided with some code reordering and 'inuse' being an=20
> atomic_t.

It's the translate and setup path, so nothing to optimize here.

